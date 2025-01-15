import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tot_pro/app/data/snackbar.dart';
export 'package:get/get.dart';
import '../../../../main.dart';
import '../../../data/core/values/app_assets.dart';
import '../../../data/core/values/app_space.dart';
import '../../../data/customIntputHeader.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Stack(
          children: [
            Container(
              height: 150,
              padding: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.2),
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(0.0),
                      bottom: Radius.circular(10.0))),
              width: double.infinity,
              child: Image.asset(
                AppAssets.appLogo,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: 110, left: 5, right: 5, bottom: 20),
              //   color: Colors.red,
              width: double.infinity,
              child: changePasswordUI(),
            ),
          ],
        ),
      ),
    );
  }

  changePasswordUI() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            AppSpace.spaceH8,
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
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
                              CustomInputHeader(header: 'Is Face ID use ?  '),
                              Obx(() {
                                return SizedBox(
                                  height: 10,
                                  child: CupertinoSwitch(
                                    activeColor: Colors.teal,
                                    value: controller.isFaceId.value,
                                    onChanged: (value) async {
                                      print('SettingsView >>  : $value');

                                      if (value == true) {
                                        print('value  if :$value');

                                        controller.isFaceId.value = true;
                                        await localStoreSRF.setBool(
                                            'isFaceId', true);
                                        successSnack('Face Id has Added ');
                                      } else {
                                        controller.isFaceId.value = false;
                                        print('value  else :$value');
                                        await localStoreSRF.setBool(
                                            'isFaceId', false);

                                        successSnack('Face Id has not Added');
                                      }
                                      print(
                                          'test:: ${controller.isFaceId.value}');
                                      print(
                                          'SettingsView. isFaceId : ${localStoreSRF.getBool('isFaceId')}');
                                    },
                                  ),
                                );
                              }),
                            ],
                          ),
                        ],
                      ),
                    )),
              ),
            ),
            AppSpace.spaceH20,
          ],
        ),
      ),
    );
  }
}
