import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:tot_pro/app/modules/home/controllers/submit_edge_controller.dart';

class CategoryView extends GetView<SubmitEdgeController> {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('Category', style: TextStyle(color: Colors.white))),
      body: Container(
        color: Colors.grey.shade300,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
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
//     controller = VideoPlayerController.file(File(videoUrl));
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
