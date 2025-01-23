import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tot_pro/utils/data/core/values/app_space.dart';
import 'package:tot_pro/screens/join_us/controllers/join_controller.dart';

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
                    child: Column(children: [
                      const Icon(Icons.file_open_outlined, size: 60),
                      AppSpace.spaceH10,
                      Text(context.tr('Add PDF or Doc'),
                          style: const TextStyle(fontWeight: FontWeight.bold))
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
