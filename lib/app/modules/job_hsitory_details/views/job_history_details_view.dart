import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import 'package:widget_zoom/widget_zoom.dart';
export 'package:get/get.dart';
import '../../../../models/job_history_details_model.dart';
import '../../../data/core/values/app_space.dart';
import '../../../data/core/values/app_url.dart';
import '../../../data/custom_text_form_field.dart';
import '../../../data/custom_widgets/custom_title_keyvalue.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          first == 'show' ? 'Job Details' : 'Update Job',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: first == 'show' ? jobDetailsUI(model) : jobDetailsEditUI(model),
    );
  }

  /// Job Details
  jobDetailsUI(JobHistoryDetailsModel model) {
    return Card(
      elevation: 0.0,
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Column(
          children: [
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
                          titleKey: 'Job Id ',
                          titleValue: model.orderid.toString()),
                      CustomTitleKeyValue(
                          titleKey: 'Name  ',
                          titleValue: model.name.toString()),
                      CustomTitleKeyValue(
                          titleKey: 'Email',
                          titleValue: model.email.toString()),
                      CustomTitleKeyValue(
                          titleKey: 'Phone',
                          titleValue: model.phone.toString()),
                      CustomTitleKeyValue(
                          titleKey: 'First Address',
                          titleValue: model.addressFirstLine.toString()),
                      CustomTitleKeyValue(
                          titleKey: 'Second Address',
                          titleValue: model.addressSecondLine.toString()),
                      CustomTitleKeyValue(
                          titleKey: 'Third Address',
                          titleValue: model.addressThirdLine.toString()),
                      CustomTitleKeyValue(
                          titleKey: 'Town', titleValue: model.town.toString()),
                      CustomTitleKeyValue(
                          titleKey: 'Post Code',
                          titleValue: model.postCode.toString()),
                      CustomTitleKeyValue(
                          titleKey: 'Date',
                          titleValue: DateFormat('dd-MMM-yyyy')
                              .format(model.date ?? DateTime.now())),
                      const Divider(
                        thickness: 0.2,
                        color: Colors.teal,
                      ),
                      AppSpace.spaceH4,
                    ],
                  ),
                ),
                AppSpace.spaceH6,
              ],
            ),
            AppSpace.spaceH6,
            model.workimage!.isEmpty
                ? Container()
                : Expanded(
                    child: ListView.builder(
                        itemCount: model.workimage!.length,
                        itemBuilder: (BuildContext context, int index) {
                          String imagePath =
                              model.workimage![index].name.toString();
                          print('imagePath :: $imagePath');

                          String path = ApiURL.globalUrl + imagePath;

                          String extendFile = imagePath.split('.').last;
                          controller.basename.value = extendFile;
                          print('basename :: $extendFile');
                          controller.controllerVPlayer =
                              VideoPlayerController.network(path);
                          //_controller = VideoPlayerController.asset("videos/sample_video.mp4");
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(5),
                                  margin:
                                      const EdgeInsets.only(top: 0, bottom: 5),
                                  width: double.infinity,
                                  color: Colors.white,
                                  child: Text(
                                    model.workimage![index].description
                                        .toString(),
                                  ),
                                ),

                                // Obx(() {

                                // return
                                extendFile.toLowerCase() == 'jpg' ||
                                        extendFile == 'png' ||
                                        extendFile == 'bmp' ||
                                        extendFile == 'webp' ||
                                        extendFile == 'heic' ||
                                        extendFile == 'jpge'
                                    ? Container(
                                        height: 120,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 5),
                                        decoration: BoxDecoration(
                                            color: Colors.red.shade50,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child:
                                            imageShowWithZoom(imagePath, index)
                                        //imageShowWithZoom(widget.pathh!.image.toString(),widget.index??0)

                                        /* WidgetZoom(
                      heroAnimationTag: 'ere',
                      zoomWidget: Image.network(
                        '${ApiURL.globalUrl + widget.pathh!.image.toString()}',
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    )*/
                                        // imageShowWithZoom(ApiURL.globalUrl + widget.pathh!.image.toString())

                                        /*InkWell(
                onTap: (){

                  imageShowWithZoom(ApiURL.globalUrl+widget.pathh!.image.toString());
                 // fullScreen(ApiURL.globalUrl+widget.pathh!.image.toString());

                },
                child: Image.network('${ApiURL.globalUrl + widget.pathh!.image.toString()}',
                  alignment: Alignment.center,
                  fit: BoxFit.fill,
                  // height: 180,
                  width: double.infinity,
                ),
              )*/
                                        ,
                                      )
                                    : VideoPlay(
                                        path: model.workimage![index].name)
                                /*FutureBuilder(
                                    future:
                                    controller.initializeVideoPlayerFuture,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.done) {
                                        return Column(
                                          children: [
                                            Center(
                                              child: AspectRatio(
                                                aspectRatio: controller
                                                    .controllerVPlayer
                                                    .value
                                                    .aspectRatio,
                                                child: VideoPlayer(
                                                    controller.controllerVPlayer),
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                if (controller.controllerVPlayer.value.isPlaying) {
                                                  controller.controllerVPlayer.pause();
                                                  controller.isPause.value = controller.controllerVPlayer.value.isPlaying;
                                                } else {
                                                  controller.controllerVPlayer
                                                      .play();
                                                  controller.isPause.value =
                                                      controller.controllerVPlayer
                                                          .value.isPlaying;
                                                }
                                              },
                                              child: Obx(()=> Icon(controller.isPause.value
                                                  ? Icons.pause
                                                  : Icons.play_arrow)),
                                            )
                                          ],
                                        );
                                      } else {
                                        return Center(child: LinearProgressIndicator());
                                      }
                                    },
                                  )*/
                                //    :

                                //  }),
                              ],
                            ),
                          );
                        }),
                  )
          ],
        ),
      ),
    );
  }

  /// Image with Zoom
  imageShowWithZoom(String imagePath, int index) {
    return WidgetZoom(
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
                // LinearProgressIndicator()
                LinearProgressIndicator(
                  backgroundColor: Colors.grey,

                  valueColor: const AlwaysStoppedAnimation(Colors.green),
                  //  strokeWidth: 5,

                  // strokeWidth: 2.0,
                  //  valueColor : AlwaysStoppedAnimation(Colors.red.shade100),
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
                AppSpace.spaceH4,
                const Text(
                  'Loading...',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                ),
              ],
            ),
          );
        },
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );

    /*PhotoView(
        imageProvider:// Image.network('src')
        CachedNetworkImageProvider('${ApiURL.globalUrl + imagePath}'),
      );*/

    Image.network(
      ApiURL.globalUrl + imagePath,
      alignment: Alignment.center,
      fit: BoxFit.fitWidth,
      // height: 180,
      width: double.infinity,
    );
  }

  /// Video

  /// Job Edit
  jobDetailsEditUI(JobHistoryDetailsModel model) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Name'),
            AppSpace.spaceH6,
            CustomTextFormField(
              controller: TextEditingController(
                text: model.name,
              ),
              textInputType: TextInputType.text,
            ),
            AppSpace.spaceH10,
            const Text('Email'),
            AppSpace.spaceH6,
            CustomTextFormField(
              controller: TextEditingController(text: model.email),
              textInputType: TextInputType.text,
            ),
            AppSpace.spaceH10,
            const Text('Address First Line'),
            AppSpace.spaceH6,
            CustomTextFormField(
              controller: TextEditingController(text: model.addressFirstLine),
              textInputType: TextInputType.text,
            ),
            AppSpace.spaceH10,
            const Text('Address Second Line'),
            AppSpace.spaceH6,
            CustomTextFormField(
              controller: TextEditingController(text: model.addressSecondLine),
              textInputType: TextInputType.text,
            ),
            AppSpace.spaceH10,
            const Text('Address Third Line'),
            AppSpace.spaceH6,
            CustomTextFormField(
              controller: TextEditingController(text: model.addressThirdLine),
              textInputType: TextInputType.text,
            ),
            AppSpace.spaceH10,
            const Text('Town'),
            AppSpace.spaceH6,
            CustomTextFormField(
              controller: TextEditingController(text: model.town),
              textInputType: TextInputType.text,
            ),
            AppSpace.spaceH10,
            const Text('Post Code'),
            AppSpace.spaceH6,
            CustomTextFormField(
              controller: TextEditingController(text: model.postCode),
              textInputType: TextInputType.text,
            ),
            AppSpace.spaceH10,
            const Divider(
              thickness: 0.2,
              color: Colors.teal,
            ),
            InkWell(
              onTap: () {
                Get.snackbar('Alert', 'Server error');
              },
              child: Container(
                width: double.maxFinite,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                    child: Text(
                  "Submit".toUpperCase(),
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                )),
              ),
            ),
            AppSpace.spaceH20,
          ],
        ),
      ),
    );
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
  String? path;

  @override
  _VideoPlayState createState() => _VideoPlayState();

  VideoPlay({
    super.key,
    this.path, // Video from assets folder
  });
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
            /*
            Container(
              alignment:  Alignment.center,
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.only(top: 0,bottom: 5),
              width: double.infinity,
              decoration: BoxDecoration(
                  color:  Colors.red.shade400,
                  borderRadius: BorderRadius.circular(5)),

              child: Text('Image',
                style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
            ),
            widget.path!='null'?
            Container(
              height: 200,
              padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),

              decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(10)),
              child: InkWell(
                onTap: (){
                  fullScreen(ApiURL.globalUrl+widget.path.toString());

                },
                child: Image.network('${ApiURL.globalUrl + widget.path.toString()}',
                  alignment: Alignment.center,
                  fit: BoxFit.fill,
                  // height: 180,
                  width: double.infinity,
                ),
              ),
            ):Container(
                height: 200,
                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(10)),
                child:  Image.asset('assets/images/no_image_found.png')),
            widget.path!='null'?
            Container(
              alignment:  Alignment.center,
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.only(top: 0,bottom: 5),
              width: double.infinity,
              decoration: BoxDecoration(
                  color:  Colors.red.shade400,
                  borderRadius: BorderRadius.circular(5)),

              child: Text('Video',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
            ):Container(),*/
            AppSpace.spaceH4,
            widget.path.toString() != 'null'
                ? SizedBox(
                    height: 220,
                    child: FutureBuilder(
                      future: futureController,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          //return const CircularProgressIndicator.adaptive();
                          return const Center(
                              child: CircularProgressIndicator.adaptive(
                            strokeWidth: 8,
                            backgroundColor: Colors.red,
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
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(10)),
                    child: Image.asset('assets/images/not_video_found.png'),
                  ),
          ],
        ),
      ),
    );
  }
}

// class VideoPlay1 extends StatefulWidget {
//   String? path;
//   int? index;

//   @override
//   _VideoPlay1State createState() => _VideoPlay1State();

//   VideoPlay1({super.key, this.path, this.index // Video from assets folder
//       });
// }

// class _VideoPlay1State extends State<VideoPlay1> {
//   ValueNotifier<VideoPlayerValue?> currentPosition = ValueNotifier(null);
//   VideoPlayerController? controller;
//   late Future<void> futureController;

//   initVideo() {
//     //print('Init Video path :: ${ApiURL.globalUrl +widget.path.toString()}');
//     String videoUrl = widget.path.toString();
//     print('_VideoPlay1State.initVideo Path >> $videoUrl ');
//     controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
//     futureController = controller!.initialize();
//   }

//   @override
//   void initState() {
//     //print('testing Video PAth :${widget.path.String()}');
//     if (widget.path!.toString() != 'null') {
//       initVideo();
//       controller!.addListener(() {
//         if (controller!.value.isInitialized) {
//           currentPosition.value = controller!.value;
//         }
//       });
//     }

//     super.initState();
//   }

//   @override
//   void dispose() {
//     controller!.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 0.0,
//       color: Colors.white,
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 5),
//         margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             AppSpace.spaceH4,
//             widget.path.toString() != 'null'
//                 ? SizedBox(
//                     height: 220,
//                     child: FutureBuilder(
//                       future: futureController,
//                       builder: (BuildContext context, AsyncSnapshot snapshot) {
//                         if (snapshot.connectionState ==
//                             ConnectionState.waiting) {
//                           //return const CircularProgressIndicator.adaptive();
//                           return const Center(
//                               child: CircularProgressIndicator.adaptive(
//                             strokeWidth: 8,
//                             backgroundColor: Colors.red,
//                           ));
//                         } else {
//                           return Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 0, vertical: 0),
//                             child: SizedBox(
//                               height: controller!.value.size.height,
//                               width: double.infinity,
//                               child: AspectRatio(
//                                   aspectRatio: controller!.value.aspectRatio,
//                                   child: Stack(children: [
//                                     Positioned.fill(
//                                         child: Container(
//                                             foregroundDecoration: BoxDecoration(
//                                               gradient: LinearGradient(
//                                                   colors: [
//                                                     Colors.black
//                                                         .withOpacity(.7),
//                                                     Colors.transparent
//                                                   ],
//                                                   stops: const [
//                                                     0,
//                                                     .3
//                                                   ],
//                                                   begin: Alignment.bottomCenter,
//                                                   end: Alignment.topCenter),
//                                             ),
//                                             child: VideoPlayer(controller!))),
//                                     Positioned.fill(
//                                       child: Column(
//                                         children: [
//                                           Expanded(
//                                             flex: 8,
//                                             child: Row(
//                                               children: [
//                                                 Expanded(
//                                                   flex: 3,
//                                                   child: GestureDetector(
//                                                     onDoubleTap: () async {
//                                                       Duration? position =
//                                                           await controller!
//                                                               .position;
//                                                       setState(() {
//                                                         controller!.seekTo(Duration(
//                                                             seconds: position!
//                                                                     .inSeconds -
//                                                                 10));
//                                                       });
//                                                     },
//                                                     child: const Icon(
//                                                       Icons.fast_rewind_rounded,
//                                                       color: Colors.black,
//                                                       size: 40,
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 Expanded(
//                                                     flex: 4,
//                                                     child: IconButton(
//                                                       icon: Icon(
//                                                         controller!
//                                                                 .value.isPlaying
//                                                             ? Icons.pause
//                                                             : Icons.play_arrow,
//                                                         color: Colors.black,
//                                                         size: 40,
//                                                       ),
//                                                       onPressed: () {
//                                                         setState(() {
//                                                           if (controller!.value
//                                                               .isPlaying) {
//                                                             controller!.pause();
//                                                           } else {
//                                                             controller!.play();
//                                                           }
//                                                         });
//                                                       },
//                                                     )),
//                                                 Expanded(
//                                                   flex: 3,
//                                                   child: GestureDetector(
//                                                     onDoubleTap: () async {
//                                                       Duration? position =
//                                                           await controller!
//                                                               .position;
//                                                       setState(() {
//                                                         controller!.seekTo(Duration(
//                                                             seconds: position!
//                                                                     .inSeconds +
//                                                                 10));
//                                                       });
//                                                     },
//                                                     child: const Icon(
//                                                       Icons
//                                                           .fast_forward_rounded,
//                                                       color: Colors.black,
//                                                       size: 40,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           Expanded(
//                                               flex: 2,
//                                               child: Align(
//                                                 alignment:
//                                                     Alignment.bottomCenter,
//                                                 child: ValueListenableBuilder(
//                                                     valueListenable:
//                                                         currentPosition,
//                                                     builder: (context,
//                                                         VideoPlayerValue?
//                                                             videoPlayerValue,
//                                                         w) {
//                                                       return Padding(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                 .symmetric(
//                                                                 horizontal: 20,
//                                                                 vertical: 10),
//                                                         child: Row(
//                                                           children: [
//                                                             Text(
//                                                               videoPlayerValue!.position.toString().substring(
//                                                                   videoPlayerValue
//                                                                           .position
//                                                                           .toString()
//                                                                           .indexOf(
//                                                                               ':') +
//                                                                       1,
//                                                                   videoPlayerValue
//                                                                       .position
//                                                                       .toString()
//                                                                       .indexOf(
//                                                                           '.')),
//                                                               style: const TextStyle(
//                                                                   color: Colors
//                                                                       .white,
//                                                                   fontSize: 22),
//                                                             ),
//                                                             const Spacer(),
//                                                             Text(
//                                                               videoPlayerValue.duration.toString().substring(
//                                                                   videoPlayerValue
//                                                                           .duration
//                                                                           .toString()
//                                                                           .indexOf(
//                                                                               ':') +
//                                                                       1,
//                                                                   videoPlayerValue
//                                                                       .duration
//                                                                       .toString()
//                                                                       .indexOf(
//                                                                           '.')),
//                                                               style: const TextStyle(
//                                                                   color: Colors
//                                                                       .white,
//                                                                   fontSize: 22),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       );
//                                                     }),
//                                               ))
//                                         ],
//                                       ),
//                                     ),
//                                   ])),
//                             ),
//                           );
//                         }
//                       },
//                     ),
//                   )
//                 : Container(
//                     height: 200,
//                     padding:
//                         const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
//                     decoration: BoxDecoration(
//                         color: Colors.red.shade50,
//                         borderRadius: BorderRadius.circular(10)),
//                     child: Image.asset('assets/images/not_video_found.png'),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }
