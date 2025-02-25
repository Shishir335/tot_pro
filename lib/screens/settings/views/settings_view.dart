import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tot_pro/components/app_bar.dart';
import 'package:tot_pro/utils/data/core/values/app_colors.dart';
export 'package:get/get.dart';
import '../../../utils/data/core/values/app_assets.dart';
import '../../../utils/data/core/values/app_space.dart';
import '../../../utils/data/customIntputHeader.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: const CustomAppBar(title: 'Settings'),
      body: Stack(
        children: [
          Container(
              height: 150,
              padding: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.2),
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(0.0),
                      bottom: Radius.circular(10.0))),
              width: double.infinity,
              child: Image.asset(AppAssets.appLogo)),
          Container(
              margin: const EdgeInsets.only(
                  top: 110, left: 5, right: 5, bottom: 20),
              width: double.infinity,
              child: changePasswordUI(context))
        ],
      ),
    );
  }

  changePasswordUI(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            if (Platform.isAndroid) AppSpace.spaceH8,
            if (Platform.isAndroid)
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 5.0),
                  child: Form(
                      key: controller.changePasswordFormKey,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomInputHeader(
                                    header: context.tr('Is Face ID use?')),
                                SizedBox(
                                  height: 10,
                                  child: CupertinoSwitch(
                                    activeColor: Colors.teal,
                                    value: controller.isFaceId,
                                    onChanged: (value) {
                                      controller.changeFaceIdUse(value);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                ),
              ),
            AppSpace.spaceH20,
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomInputHeader(
                            header:
                                '${context.tr('Change Language to ')}${controller.language == 'ro' ? 'English' : 'Roman'}'),
                        SizedBox(
                          height: 10,
                          child: CupertinoSwitch(
                            activeColor: Colors.teal,
                            value: controller.language == 'en' ? true : false,
                            onChanged: (value) async {
                              if (controller.language == 'ro') {
                                controller.changeLanguage('en');
                              } else {
                                controller.changeLanguage('ro');
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
