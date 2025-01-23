import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tot_pro/components/app_bar.dart';
export 'package:get/get.dart';
import '../../../utils/data/core/values/app_assets.dart';
import '../../../utils/data/core/values/app_helper.dart';
import '../../../utils/data/core/values/app_space.dart';
import '../../../utils/data/core/values/app_strings.dart';
import '../../../utils/data/customIntputHeader.dart';
import '../../../utils/data/custom_text_form_field.dart';
import '../controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: const CustomAppBar(title: 'Change Password'),
      body: Stack(
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
              child: Image.asset(AppAssets.appLogo)),
          Container(
              margin: const EdgeInsets.only(
                  top: 110, left: 5, right: 5, bottom: 20),
              width: double.infinity,
              child: changePasswordUI()),
        ],
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
                            CustomInputHeader(header: 'Old Password'.tr),
                            AppSpace.spaceH6,
                            Obx(() => CustomTextFormField(
                                suffix: InkWell(
                                    onTap: () {
                                      controller.isShowOldPassword.value =
                                          !controller.isShowOldPassword.value;
                                    },
                                    child: Container(
                                        child: controller
                                                .isShowOldPassword.value
                                            ? const Icon(Icons.visibility_off)
                                            : const Icon(Icons.visibility))),
                                suffixConstraints:
                                    const BoxConstraints(maxHeight: 36),
                                obscureText: controller.isShowOldPassword.value,
                                controller: controller.oldPasswordCTL,
                                textInputType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return AppStrings.emptyInputFieldMsg;
                                  }
                                  if (value.length < 8) {
                                    return AppStrings.passwordMustBe8Digit;
                                  }
                                  return null;
                                })),
                            AppSpace.spaceH10,
                            CustomInputHeader(header: 'Current Password'.tr),
                            AppSpace.spaceH6,
                            Obx(
                              () => CustomTextFormField(
                                suffix: InkWell(
                                    onTap: () {
                                      controller.isShowNewPassword.value =
                                          !controller.isShowNewPassword.value;
                                    },
                                    child: Container(
                                        child: controller
                                                .isShowNewPassword.value
                                            ? const Icon(Icons.visibility_off)
                                            : const Icon(Icons.visibility))),
                                suffixConstraints:
                                    const BoxConstraints(maxHeight: 36),
                                obscureText: controller.isShowNewPassword.value,
                                controller: controller.newPasswordCTL,
                                textInputType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return AppStrings.emptyInputFieldMsg;
                                  }
                                  if (value.length < 8) {
                                    return AppStrings.passwordMustBe8Digit;
                                  }
                                  return null;
                                },
                              ),
                            ),
                            AppSpace.spaceH10,
                            CustomInputHeader(header: 'Confirm Password'.tr),
                            AppSpace.spaceH6,
                            Obx(
                              () => CustomTextFormField(
                                suffix: InkWell(
                                    onTap: () {
                                      controller.isShowConfirmPassword.value =
                                          !controller
                                              .isShowConfirmPassword.value;
                                    },
                                    child: Container(
                                      child:
                                          controller.isShowConfirmPassword.value
                                              ? const Icon(Icons.visibility_off)
                                              : const Icon(Icons.visibility),
                                    )),
                                suffixConstraints:
                                    const BoxConstraints(maxHeight: 36),
                                obscureText:
                                    controller.isShowConfirmPassword.value,
                                controller: controller.confirmPasswordCTL,
                                textInputType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return AppStrings.emptyInputFieldMsg;
                                  }
                                  if (value.length < 8) {
                                    return AppStrings.passwordMustBe8Digit;
                                  }
                                  return null;
                                },
                              ),
                            ),
                            AppSpace.spaceH20,
                            InkWell(
                                onTap: () {
                                  if (controller
                                      .changePasswordFormKey.currentState!
                                      .validate()) {
                                    if (controller.newPasswordCTL.text ==
                                        controller.confirmPasswordCTL.text) {
                                      controller.changePasswordController();
                                    } else {
                                      Helpers.snackbarForErorr(
                                          titleText: 'Error Alert'.tr,
                                          bodyText:
                                              'New password and confirm password are not match!'
                                                  .tr);
                                    }
                                  }
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
                                            "Change Password".tr.toUpperCase(),
                                            style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.white))))),
                            AppSpace.spaceH10
                          ]),
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
