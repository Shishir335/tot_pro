import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tot_pro/components/app_bar.dart';
import 'package:tot_pro/utils/data/core/values/app_colors.dart';
import 'package:video_player/video_player.dart';
import 'package:widget_zoom/widget_zoom.dart';
export 'package:get/get.dart';
import '../../../models/job_history_details_model.dart';
import '../../../utils/data/core/values/app_space.dart';
import '../../../utils/data/core/values/app_url.dart';
import '../../../utils/data/custom_text_form_field.dart';
import '../../../utils/data/custom_widgets/custom_title_keyvalue.dart';
import '../controllers/job_history_details_controller.dart';

class JobHistoryDetailsView extends GetView<JobHistoryDetailsController> {
  const JobHistoryDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    var pageActivity = Get.arguments;
    String first = pageActivity[0]['first'];
    JobHistoryDetailsModel model = pageActivity[1]['second'];
    return Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: CustomAppBar(
            title: context.tr(first == 'show' ? 'Job Details' : 'Update Job')),
        body: first == 'show'
            ? jobDetailsUI(model, context)
            : jobDetailsEditUI(model, context));
  }

  /// Job Details
  jobDetailsUI(JobHistoryDetailsModel model, BuildContext context) {
    return Card(
        elevation: 0.0,
        color: Colors.white,
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Column(children: [
              Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 5,
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomTitleKeyValue(
                                  titleKey: context.tr('Job Id'),
                                  titleValue: model.orderid.toString()),
                              CustomTitleKeyValue(
                                  titleKey: context.tr('Name'),
                                  titleValue: model.name.toString()),
                              CustomTitleKeyValue(
                                  titleKey: context.tr('Email'),
                                  titleValue: model.email.toString()),
                              CustomTitleKeyValue(
                                  titleKey: context.tr('Phone'),
                                  titleValue: model.phone.toString()),
                              CustomTitleKeyValue(
                                  titleKey: context.tr('First Address'),
                                  titleValue:
                                      model.addressFirstLine.toString()),
                              CustomTitleKeyValue(
                                  titleKey: context.tr('Second Address'),
                                  titleValue:
                                      model.addressSecondLine.toString()),
                              CustomTitleKeyValue(
                                  titleKey: context.tr('Third Address'),
                                  titleValue:
                                      model.addressThirdLine.toString()),
                              CustomTitleKeyValue(
                                  titleKey: context.tr('Town'),
                                  titleValue: model.town.toString()),
                              CustomTitleKeyValue(
                                  titleKey: context.tr('Post Code'),
                                  titleValue: model.postCode.toString()),
                              CustomTitleKeyValue(
                                  titleKey: context.tr('Date'),
                                  titleValue: DateFormat('dd-MMM-yyyy')
                                      .format(model.date ?? DateTime.now())),
                              const Divider(thickness: 0.2, color: Colors.teal),
                              AppSpace.spaceH4
                            ])),
                    AppSpace.spaceH6
                  ]),
              AppSpace.spaceH6,
              model.workimage!.isEmpty
                  ? Container()
                  : Expanded(
                      child: ListView.builder(
                          itemCount: model.workimage!.length,
                          itemBuilder: (BuildContext context, int index) {
                            String imagePath =
                                model.workimage![index].name.toString();
                            String path = ApiURL.globalUrl + imagePath;
                            String extendFile = imagePath.split('.').last;
                            controller.basename.value = extendFile;
                            controller.controllerVPlayer =
                                VideoPlayerController.network(path);
                            controller.initializeVideoPlayerFuture =
                                controller.controllerVPlayer.initialize();
                            controller.controllerVPlayer.setLooping(true);
                            controller.controllerVPlayer.setVolume(1.0);

                            return Container(
                                color: Colors.grey.withOpacity(0.3),
                                margin: const EdgeInsets.all(0),
                                padding: const EdgeInsets.all(5),
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.all(5),
                                          margin: const EdgeInsets.only(
                                              top: 0, bottom: 5),
                                          width: double.infinity,
                                          color: Colors.white,
                                          child: Text(model
                                              .workimage![index].description
                                              .toString())),
                                      extendFile.toLowerCase() == 'jpg' ||
                                              extendFile == 'png' ||
                                              extendFile == 'bmp' ||
                                              extendFile == 'webp' ||
                                              extendFile == 'heic' ||
                                              extendFile == 'jpge'
                                          ? Container(
                                              height: 120,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 5),
                                              decoration: BoxDecoration(
                                                  color: AppColors.primaryColor
                                                      .withOpacity(.5),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: imageShowWithZoom(
                                                  imagePath, index))
                                          : VideoPlay(
                                              path:
                                                  model.workimage![index].name)
                                    ]));
                          }))
            ])));
  }

  /// Image with Zoom
  imageShowWithZoom(String imagePath, int index) {
    return WidgetZoom(
        heroAnimationTag: index,
        zoomWidget: Image.network(ApiURL.globalUrl + imagePath, height: 120,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                LinearProgressIndicator(
                  backgroundColor: Colors.grey,
                  valueColor: const AlwaysStoppedAnimation(Colors.green),
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
                AppSpace.spaceH4,
                Text(context.tr('Loading...'),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor))
              ]));
        }, width: double.infinity, fit: BoxFit.cover));
  }

  /// Video

  /// Job Edit
  jobDetailsEditUI(JobHistoryDetailsModel model, BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(context.tr('Name')),
                  AppSpace.spaceH6,
                  CustomTextFormField(
                      controller: TextEditingController(text: model.name),
                      textInputType: TextInputType.text),
                  AppSpace.spaceH10,
                  Text(context.tr('Email')),
                  AppSpace.spaceH6,
                  CustomTextFormField(
                      controller: TextEditingController(text: model.email),
                      textInputType: TextInputType.text),
                  AppSpace.spaceH10,
                  Text(context.tr('Address First Line')),
                  AppSpace.spaceH6,
                  CustomTextFormField(
                      controller:
                          TextEditingController(text: model.addressFirstLine),
                      textInputType: TextInputType.text),
                  AppSpace.spaceH10,
                  Text(context.tr('Address Second Line')),
                  AppSpace.spaceH6,
                  CustomTextFormField(
                      controller:
                          TextEditingController(text: model.addressSecondLine),
                      textInputType: TextInputType.text),
                  AppSpace.spaceH10,
                  Text(context.tr('Address Third Line')),
                  AppSpace.spaceH6,
                  CustomTextFormField(
                      controller:
                          TextEditingController(text: model.addressThirdLine),
                      textInputType: TextInputType.text),
                  AppSpace.spaceH10,
                  Text(context.tr('Town')),
                  AppSpace.spaceH6,
                  CustomTextFormField(
                    controller: TextEditingController(text: model.town),
                    textInputType: TextInputType.text,
                  ),
                  AppSpace.spaceH10,
                  Text(context.tr('Post Code')),
                  AppSpace.spaceH6,
                  CustomTextFormField(
                    controller: TextEditingController(text: model.postCode),
                    textInputType: TextInputType.text,
                  ),
                  AppSpace.spaceH10,
                  const Divider(thickness: 0.2, color: Colors.teal),
                  InkWell(
                      onTap: () {
                        Get.snackbar(
                            context.tr('Alert'), context.tr('Server error'));
                      },
                      child: Container(
                          width: double.maxFinite,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                              child: Text(context.tr("Submit").toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.white))))),
                  AppSpace.spaceH20
                ])));
  }

  fullScreen(String imagePath) {
    return Get.dialog(
      AlertDialog(
        title: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.close)),
        content: Image.network(imagePath),
      ),
    );
  }
}

class VideoPlay extends StatefulWidget {
  final String? path;

  @override
  _VideoPlayState createState() => _VideoPlayState();

  const VideoPlay({super.key, this.path});
}

class _VideoPlayState extends State<VideoPlay> {
  ValueNotifier<VideoPlayerValue?> currentPosition = ValueNotifier(null);
  VideoPlayerController? controller;
  late Future<void> futureController;

  initVideo() {
    print('Init Video path :: ${ApiURL.globalUrl + widget.path.toString()}');
    String videoUrl = ApiURL.globalUrl + widget.path.toString();
    controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
    futureController = controller!.initialize();
  }

  @override
  void initState() {
    //print('testing Video PAth :${widget.path.String()}');
    if (widget.path!.toString() != 'null') {
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
            AppSpace.spaceH4,
            widget.path.toString() != 'null'
                ? SizedBox(
                    height: 220,
                    child: FutureBuilder(
                      future: futureController,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child: CircularProgressIndicator.adaptive(
                            strokeWidth: 8,
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
}
