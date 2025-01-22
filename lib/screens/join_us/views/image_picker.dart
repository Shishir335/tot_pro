import 'dart:io';
// import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tot_pro/utils/data/core/values/app_space.dart';
import 'package:tot_pro/screens/join_us/controllers/join_controller.dart';
import 'package:widget_zoom/widget_zoom.dart';

class CVPicker extends StatelessWidget {
  const CVPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JoinController>(builder: (controller) {
      return SizedBox(
          child: controller.cv == null
              ? InkWell(
                  onTap: () {
                    controller.pickFile();
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Column(children: [
                      Icon(Icons.file_open_outlined, size: 60),
                      AppSpace.spaceH10,
                      Text('Add PDF or Doc',
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
                                // AppSpace.spaceH6,
                                // DottedBorder(
                                //     borderType: BorderType.RRect,
                                //     radius: const Radius.circular(10),
                                //     padding: const EdgeInsets.all(2),
                                //     child: ClipRRect(
                                //         borderRadius: const BorderRadius.all(
                                //             Radius.circular(10)),
                                //         child: Container(
                                //             height: 250,
                                //             padding: const EdgeInsets.all(0),
                                //             alignment: Alignment.center,
                                //             child: Image.file(
                                //                 File(controller.cv!.path))))),
                                AppSpace.spaceH4,
                                Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white),
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                        'File Path :${controller.cv!.path.split('/').last} ',
                                        style: const TextStyle(fontSize: 14))),
                                AppSpace.spaceH4
                              ])))));
    });
  }
}
