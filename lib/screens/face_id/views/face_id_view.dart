import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tot_pro/components/app_bar.dart';
import 'package:tot_pro/utils/data/core/values/app_colors.dart';
import 'package:tot_pro/utils/data/core/values/app_space.dart';
export 'package:get/get.dart';
import '../../../utils/routes/app_pages.dart';
import '../controllers/face_id_controller.dart';

class FaceIdAuthView extends GetView<FaceIdAuthController> {
  const FaceIdAuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: 'Face ID'),
        body: Obx(() {
          return ListView(
            padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 20),
                  Text(context.tr('Unlock with your Face ID'),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18)),
                  const SizedBox(height: 20),
                  Text('Current State: ${controller.authorized}\n'),
                  const SizedBox(height: 20),
                  controller.authorized.value == 'Authenticating'
                      ? Image.asset('assets/faceid/faceloading.gif',
                          height: 200, width: 200)
                      : controller.authorized.value == 'Authorized'
                          ? Image.asset('assets/faceid/facebefore.jpeg',
                              height: 200, width: 200)
                          : Image.asset('assets/faceid/face-id.png',
                              height: 100, width: 100),
                  const SizedBox(height: 100),
                  Column(
                    children: <Widget>[
                      InkWell(
                          onTap: () {
                            controller.authenticateWithBiometrics();
                          },
                          child: Container(
                              width: double.maxFinite,
                              margin: const EdgeInsets.all(10),
                              height: 50,
                              decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                  child: Text(
                                      context.tr("USE FACE ID").toUpperCase(),
                                      style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.white))))),
                      InkWell(
                          onTap: () {
                            controller.authenticate();
                          },
                          child: Container(
                              width: double.maxFinite,
                              margin: const EdgeInsets.all(10),
                              height: 50,
                              decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                  child: Text(
                                      context.tr("Password").toUpperCase(),
                                      style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.white))))),
                      AppSpace.spaceH8,
                      InkWell(
                          onTap: () {
                            Get.offNamedUntil(Routes.LOGIN, (route) => false);
                          },
                          child: Text(context.tr('Back To The Login'),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold))),
                    ],
                  ),
                ],
              ),
            ],
          );
        }));
  }

  faceUI(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(context.tr('Allow sign in with Face ID ?'),
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 50),
          const Icon(Icons.face, size: 150),
          const SizedBox(height: 50),
          ElevatedButton(
              onPressed: () {},
              child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Text(context.tr('Face ID')),
                const SizedBox(width: 20),
                const Icon(Icons.fingerprint)
              ])),
          const SizedBox(height: 15),
          Text(context.tr('Maybe later'))
        ]);
  }
}
