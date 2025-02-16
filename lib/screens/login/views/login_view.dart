import 'package:dotted_line/dotted_line.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tot_pro/components/app_bar.dart';
import 'package:tot_pro/utils/data/core/values/app_colors.dart';
import 'package:tot_pro/utils/data/core/values/app_strings.dart';
export 'package:get/get.dart';
import '../../../utils/data/core/values/app_assets.dart';
import '../../../utils/data/core/values/app_space.dart';
import '../../../utils/data/customIntputHeader.dart';
import '../../../utils/data/custom_text_form_field.dart';
import '../../face_id/views/face_id_view.dart';
import '../controllers/login_controller.dart';
import '../../../utils/routes/app_pages.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: CustomAppBar(title: context.tr('Login')),
        body: Stack(children: [
          Container(
              height: 150,
              padding: const EdgeInsets.only(top: 0, bottom: 50),
              decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.2),
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(0.0),
                      bottom: Radius.circular(10.0))),
              width: double.infinity,
              child: Image.asset(AppAssets.appLogo)),
          Container(
              margin: const EdgeInsets.only(
                  top: 100, left: 5, right: 5, bottom: 20),
              width: double.infinity,
              child: loginUI(context))
        ]));
  }

  Widget loginUI(BuildContext context) {
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
                    key: controller.loginFormKey,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppSpace.spaceH6,
                          CustomInputHeader(header: context.tr('Email')),
                          AppSpace.spaceH6,
                          CustomTextFormField(
                            controller: controller.mailCTL,
                            textInputType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return context.tr('Please enter your email');
                              }
                              return null;
                            },
                          ),
                          AppSpace.spaceH10,
                          CustomInputHeader(header: context.tr('Password')),
                          AppSpace.spaceH6,
                          Obx(() => CustomTextFormField(
                              suffix: InkWell(
                                  onTap: () {
                                    controller.isLoginShowPassword.value =
                                        !controller.isLoginShowPassword.value;
                                  },
                                  child: Container(
                                    child: controller.isLoginShowPassword.value
                                        ? const Icon(Icons.visibility_off)
                                        : const Icon(Icons.visibility),
                                  )),
                              suffixConstraints:
                                  const BoxConstraints(maxHeight: 36),
                              obscureText: controller.isLoginShowPassword.value,
                              controller: controller.passwordCTL,
                              textInputType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppStrings.emptyInputFieldMsg;
                                } else if (value.length < 8) {
                                  return AppStrings.passwordMustBe8Digit;
                                }
                                return null;
                              })),
                          AppSpace.spaceH20,
                          InkWell(
                              onTap: () {
                                if (controller.loginFormKey.currentState!
                                    .validate()) {
                                  controller.loginController();
                                }
                              },
                              child: Container(
                                  width: double.maxFinite,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                      child: Text(
                                          context.tr("Submit").toUpperCase(),
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.white))))),
                          AppSpace.spaceH10,
                          const DottedLine(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.center,
                            lineLength: double.infinity,
                            lineThickness: 1.0,
                            dashLength: 6.0,
                            dashColor: Colors.black,
                            dashRadius: 0.0,
                            dashGapLength: 4.0,
                            dashGapColor: Colors.transparent,
                            dashGapRadius: 0.0,
                          ),
                          AppSpace.spaceH10,
                          Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                    onTap: () {
                                      Get.toNamed(Routes.REGISTER);
                                    },
                                    child: Text(
                                        context.tr(
                                            'Need an account? Register Now'),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)))
                              ]),
                          AppSpace.spaceH20,
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
