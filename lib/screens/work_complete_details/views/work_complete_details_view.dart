import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tot_pro/components/app_bar.dart';
import 'package:tot_pro/utils/data/core/values/app_colors.dart';
import 'package:video_player/video_player.dart';
import 'package:widget_zoom/widget_zoom.dart';
export 'package:get/get.dart';
import '../../../models/completed_work_model.dart';
import '../../../utils/data/core/values/app_space.dart';
import '../../../utils/data/core/values/app_url.dart';
import '../controllers/work_complete_details_controller.dart';

class WorkCompleteDetailsView extends GetView<WorkCompleteDetailsController> {
  const WorkCompleteDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    var pageActivity = Get.arguments;
    String OrderId = pageActivity[0]['orderId'];
    List<CompletedWorkModel> dataList = pageActivity[1]['CompletedList'];
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: CustomAppBar(
          title: '${context.tr('Order Id')} ${OrderId.toString()}'),
      body: SingleChildScrollView(
        child: Column(children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: dataList.length,
            itemBuilder: (BuildContext context, int index) {
              CompletedWorkModel model = dataList[index];
              return VideoPlay(pathh: model);
            },
          ),
        ]),
      ),
    );
  }
}

class VideoPlay extends StatefulWidget {
  final CompletedWorkModel? pathh;
  final int? index;

  @override
  _VideoPlayState createState() => _VideoPlayState();

  const VideoPlay({super.key, this.pathh, this.index});
}

class _VideoPlayState extends State<VideoPlay> {
  ValueNotifier<VideoPlayerValue?> currentPosition = ValueNotifier(null);
  VideoPlayerController? controller;
  late Future<void> futureController;

  initVideo() {
    String videoUrl = ApiURL.globalUrl + widget.pathh!.video.toString();
    controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
    futureController = controller!.initialize();
  }

  @override
  void initState() {
    if (widget.pathh!.video.toString() != 'null') {
      initVideo();
      controller!.addListener(() {
        if (controller!.value.isInitialized) {
          currentPosition.value = controller!.value;
        }
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 5),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.only(top: 0, bottom: 5),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(.4),
                    borderRadius: BorderRadius.circular(5)),
                child: Text(context.tr('Image'),
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold))),
            widget.pathh!.image != 'null'
                ? imageShowWithZoom(
                    widget.pathh!.image.toString(), widget.index ?? 0)
                : Container(
                    height: 200,
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(.5),
                        borderRadius: BorderRadius.circular(10)),
                    child: Image.asset('assets/images/no_image_found.png')),
            widget.pathh!.video != 'null'
                ? Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.only(top: 0, bottom: 5),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(.4),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(context.tr('Video'),
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)))
                : Container(),
            AppSpace.spaceH4,
            widget.pathh!.video.toString() != 'null'
                ? SizedBox(
                    height: 220,
                    child: FutureBuilder(
                      future: futureController,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          //return const CircularProgressIndicator.adaptive();
                          return Center(
                              child: CircularProgressIndicator.adaptive(
                            backgroundColor: AppColors.primaryColor,
                          ));
                        } else {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            child: SizedBox(
                              height: controller!.value.size.height,
                              width: double.infinity,
                              child: AspectRatio(
                                  aspectRatio: controller!.value.aspectRatio,
                                  child: Stack(children: [
                                    Positioned.fill(
                                        child: Container(
                                            foregroundDecoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  colors: [
                                                    Colors.black
                                                        .withOpacity(.7),
                                                    Colors.transparent
                                                  ],
                                                  stops: const [
                                                    0,
                                                    .3
                                                  ],
                                                  begin: Alignment.bottomCenter,
                                                  end: Alignment.topCenter),
                                            ),
                                            child: VideoPlayer(controller!))),
                                    Positioned.fill(
                                      child: Column(
                                        children: [
                                          Expanded(
                                            flex: 8,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 3,
                                                  child: GestureDetector(
                                                    onDoubleTap: () async {
                                                      Duration? position =
                                                          await controller!
                                                              .position;
                                                      setState(() {
                                                        controller!.seekTo(Duration(
                                                            seconds: position!
                                                                    .inSeconds -
                                                                10));
                                                      });
                                                    },
                                                    child: const Icon(
                                                      Icons.fast_rewind_rounded,
                                                      color: Colors.black,
                                                      size: 40,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                    flex: 4,
                                                    child: IconButton(
                                                      icon: Icon(
                                                        controller!
                                                                .value.isPlaying
                                                            ? Icons.pause
                                                            : Icons.play_arrow,
                                                        color: Colors.black,
                                                        size: 40,
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          if (controller!.value
                                                              .isPlaying) {
                                                            controller!.pause();
                                                          } else {
                                                            controller!.play();
                                                          }
                                                        });
                                                      },
                                                    )),
                                                Expanded(
                                                  flex: 3,
                                                  child: GestureDetector(
                                                    onDoubleTap: () async {
                                                      Duration? position =
                                                          await controller!
                                                              .position;
                                                      setState(() {
                                                        controller!.seekTo(Duration(
                                                            seconds: position!
                                                                    .inSeconds +
                                                                10));
                                                      });
                                                    },
                                                    child: const Icon(
                                                      Icons
                                                          .fast_forward_rounded,
                                                      color: Colors.black,
                                                      size: 40,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                              flex: 2,
                                              child: Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: ValueListenableBuilder(
                                                    valueListenable:
                                                        currentPosition,
                                                    builder: (context,
                                                        VideoPlayerValue?
                                                            videoPlayerValue,
                                                        w) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 20,
                                                                vertical: 10),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              videoPlayerValue!.position.toString().substring(
                                                                  videoPlayerValue
                                                                          .position
                                                                          .toString()
                                                                          .indexOf(
                                                                              ':') +
                                                                      1,
                                                                  videoPlayerValue
                                                                      .position
                                                                      .toString()
                                                                      .indexOf(
                                                                          '.')),
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 22),
                                                            ),
                                                            const Spacer(),
                                                            Text(
                                                              videoPlayerValue.duration.toString().substring(
                                                                  videoPlayerValue
                                                                          .duration
                                                                          .toString()
                                                                          .indexOf(
                                                                              ':') +
                                                                      1,
                                                                  videoPlayerValue
                                                                      .duration
                                                                      .toString()
                                                                      .indexOf(
                                                                          '.')),
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 22),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    }),
                                              ))
                                        ],
                                      ),
                                    ),
                                  ])),
                            ),
                          );
                        }
                      },
                    ),
                  )
                : Container(
                    height: 200,
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(.5),
                        borderRadius: BorderRadius.circular(10)),
                    child: Image.asset('assets/images/not_video_found.png'),
                  ),
          ],
        ),
      ),
    );
  }

  fullScreen(String imagePath) {
    print('_VideoPlayState.fullScreen >>. $imagePath');
    return Get.dialog(
      AlertDialog(
        iconPadding: const EdgeInsets.all(5),
        icon: InkWell(
            onTap: () {
              Get.back();
            },
            child: CircleAvatar(
                backgroundColor: AppColors.primaryColor,
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                ))),
        title: Image.network(
          imagePath,
          height: Get.size.width,
          width: Get.size.width,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  imageShowWithZoom(String imagePath, int index) {
    return Container(
        height: 200,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(.5),
            borderRadius: BorderRadius.circular(10)),
        child: WidgetZoom(
          heroAnimationTag: index,
          zoomWidget: Image.network(
            ApiURL.globalUrl + imagePath,
            height: 120,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(
                      backgroundColor: Colors.grey,
                      valueColor: const AlwaysStoppedAnimation(Colors.green),
                      strokeWidth: 5,
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                    AppSpace.spaceH4,
                    Text(
                      context.tr('Loading...'),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor),
                    ),
                  ],
                ),
              );
            },
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ));
  }
}
