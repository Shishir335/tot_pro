import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tot_pro/app/data/core/values/app_space.dart';
import 'package:tot_pro/app/modules/join_us/controllers/join_controller.dart';
import 'package:widget_zoom/widget_zoom.dart';

class CVPicker extends StatelessWidget {
  const CVPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JoinController>(builder: (controller) {
      return SizedBox(
          child: controller.cv == null
              ? InkWell(
                  onTap: () => showModalBottomSheet(
                        barrierColor: Colors.teal.withOpacity(0.5),
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            child: Wrap(
                              children: <Widget>[
                                ListTile(
                                    leading: const Icon(Icons.camera),
                                    title: const Text('Camera',
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold)),
                                    trailing:
                                        const Icon(Icons.touch_app_outlined),
                                    onTap: () => controller.selectImage(
                                        ImageSource.camera, 'camera')),
                                ListTile(
                                    leading: const Icon(Icons.image),
                                    title: const Text('Gallery',
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold)),
                                    trailing:
                                        const Icon(Icons.touch_app_outlined),
                                    onTap: () => controller.selectImage(
                                        ImageSource.gallery, 'gallery')),
                              ],
                            ),
                          );
                        },
                      ),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(children: [
                      Image.asset('assets/images/empty_iamges.png',
                          width: 100, height: 100),
                      const Text('No Images OR Videos ',
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ]),
                  ))
              : SizedBox(
                  width: double.infinity,
                  child: Center(
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10)),
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 2),
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 5),
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(5)),
                                    width: double.infinity,
                                    alignment: Alignment.topRight,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 0),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 5),
                                    child: InkWell(
                                        onTap: () {
                                          controller.cv = null;
                                          controller.update();
                                        },
                                        child: const CircleAvatar(
                                            radius: 14,
                                            backgroundColor: Colors.red,
                                            child: Icon(Icons.close,
                                                color: Colors.white)))),
                                AppSpace.spaceH6,
                                DottedBorder(
                                    borderType: BorderType.RRect,
                                    radius: const Radius.circular(10),
                                    padding: const EdgeInsets.all(2),
                                    child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        child: Container(
                                            height: 250,
                                            padding: const EdgeInsets.all(0),
                                            alignment: Alignment.center,
                                            child: Image.file(
                                                File(controller.cv!.path))))),
                                AppSpace.spaceH4,
                                Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                        'File Path :${controller.cv!.path.split('/').last} ',
                                        style: const TextStyle(fontSize: 8))),
                                AppSpace.spaceH4
                              ])))));
    });
  }

  imageShowWithZoomInOut(String imagePath, int index) {
    return WidgetZoom(
        heroAnimationTag: index,
        zoomWidget: Image.file(
          File(imagePath),
          alignment: Alignment.center,
          fit: BoxFit.fitWidth,
          height: 250,
          width: double.infinity,
        ));
  }
}
