import 'package:field_suggestion/field_suggestion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tot_pro/app/data/core/values/app_strings.dart';
export 'package:get/get.dart';
import '../../../../models/address_model.dart';
import '../../../data/core/values/app_assets.dart';
import '../../../data/core/values/app_space.dart';
import '../../../data/customIntputHeader.dart';
import '../../../data/custom_text_form_field.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'Register ',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Stack(
          children: [
            Container(
              height: 150,
              padding: const EdgeInsets.only(top: 0, bottom: 50),
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
                  top: 100, left: 5, right: 5, bottom: 20),
              //   color: Colors.red,
              width: double.infinity,
              child: registerUI(),
            ),
          ],
        ),
      ),
    );
  }

  registerUI() {
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
                    key: controller.registerFormKey,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomInputHeader(header: 'Name'),
                          AppSpace.spaceH6,
                          CustomTextFormField(
                            controller: controller.nameCTL,
                            textInputType: TextInputType.text,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppStrings.emptyInputFieldMsg;
                              }
                              return null;
                            },
                          ),
                          AppSpace.spaceH10,
                          CustomInputHeader(header: 'Company Name'),
                          AppSpace.spaceH6,
                          CustomTextFormField(
                            controller: controller.companyCTL,
                            textInputType: TextInputType.text,
                            validator: (value) {
                              /*if (value == null || value.isEmpty) {
                                return AppStrings.emptyInputFieldMsg;
                              }*/
                              return null;
                            },
                          ),
                          AppSpace.spaceH10,
                          CustomInputHeader(header: 'Mobile Number'),
                          AppSpace.spaceH6,
                          CustomTextFormField(
                            controller: controller.mobileCTL,
                            textInputType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppStrings.emptyInputFieldMsg;
                              }
                              /*else if(value.length>11){
                                return AppStrings.phoneNumber11Digit;
                              }*/

                              return null;
                            },
                          ),
                          AppSpace.spaceH10,
                          CustomInputHeader(header: 'Address First Line'),
                          AppSpace.spaceH6,

                          ///------------ finder Address ------

                          FieldSuggestion<AddressModel>.network(
                            inputDecoration: InputDecoration(
                              // suffixIcon: suffixIc,
                              filled: true,
                              fillColor: true
                                  ? Colors.red.shade50.withOpacity(0.8)
                                  : Colors.black12,

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.greenAccent),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                            ),
                            future: (input) => controller.shouldSearch
                                ? controller.addressLineOneController.text
                                        .isNotEmpty
                                    ? controller.searchAddress(input)
                                    : controller.returnEmptyFutureData()
                                : controller.returnEmptyFutureData(),
                            textController: controller.addressLineOneController,
                            boxController: controller.boxController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppStrings.emptyInputFieldMsg;
                              }
                              return null;
                            },
                            builder: (context, snapshot) {
                              if (snapshot.connectionState !=
                                  ConnectionState.done) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              final result = snapshot.data ?? [];
                              return ListView.builder(
                                itemCount: result.length,
                                itemBuilder: (context, index) {
                                  //  print('result lng : ${snapshot.data}');
                                  return GestureDetector(
                                    onTap: () {
                                      controller.shouldSearch = false;
                                      controller.addressLineOneController.text =
                                          result[index].suggestion!;

                                      FocusScope.of(context).unfocus();
                                      controller.boxController.close?.call();
                                      controller.shouldSearch = true;

                                      /// get address details and set data to text fields
                                      if (result[index].urls != null &&
                                          result[index].urls!.udprn != null) {
                                        controller.getAndSetAddressDetails(
                                            result[index].urls!.udprn!);
                                      }
                                    },
                                    child: ListTile(
                                        title: Text(result[index].suggestion!)),
                                  );
                                },
                              );
                            },
                          ),
                          AppSpace.spaceH10,

                          ///--------- End -------------

                          CustomInputHeader(header: 'Address Second Line'),
                          AppSpace.spaceH6,
                          CustomTextFormField(
                            isReadOnly: true,
                            controller: controller.addressLineTwoController,
                            textInputType: TextInputType.text,
                            validator: (value) {
                              /* if (value == null || value.isEmpty) {
                                return AppStrings.emptyInputFieldMsg;
                              }*/
                              return null;
                            },
                          ),
                          AppSpace.spaceH10,
                          CustomInputHeader(header: 'Address Third Line'),
                          AppSpace.spaceH6,
                          CustomTextFormField(
                            isReadOnly: true,
                            controller: controller.addressLineThreeController,
                            textInputType: TextInputType.text,
                            validator: (value) {
                              /* if (value == null || value.isEmpty) {
                                return AppStrings.emptyInputFieldMsg;
                              }*/
                              return null;
                            },
                          ),
                          AppSpace.spaceH10,
                          CustomInputHeader(header: 'Town'),
                          AppSpace.spaceH6,
                          CustomTextFormField(
                            isReadOnly: true,
                            controller: controller.countryTextController,
                            textInputType: TextInputType.text,
                            validator: (value) {
                              /* if (value == null || value.isEmpty) {
                                return AppStrings.emptyInputFieldMsg;
                              }*/
                              return null;
                            },
                          ),
                          AppSpace.spaceH10,
                          CustomInputHeader(header: 'Post Code'),
                          AppSpace.spaceH6,
                          CustomTextFormField(
                            isReadOnly: true,
                            controller: controller.postcodeTextController,
                            textInputType: TextInputType.text,
                            validator: (value) {
                              /* if (value == null || value.isEmpty) {
                                return AppStrings.emptyInputFieldMsg;
                              }*/
                              return null;
                            },
                          ),
                          AppSpace.spaceH10,
                          CustomInputHeader(header: 'Email'),
                          AppSpace.spaceH6,
                          CustomTextFormField(
                            controller: controller.mailCTL,
                            textInputType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppStrings.emptyInputFieldMsg;
                              }
                              return null;
                            },
                          ),
                          AppSpace.spaceH10,
                          CustomInputHeader(header: 'Password'),
                          AppSpace.spaceH6,
                          Obx(
                            () => CustomTextFormField(
                              controller: controller.passwordCTL,
                              textInputType: TextInputType.text,
                              suffix: InkWell(
                                onTap: () {
                                  controller.isShowPassword.value =
                                      !controller.isShowPassword.value;
                                },
                                child: Container(
                                    child: controller.isShowPassword.value
                                        ? const Icon(Icons.visibility_off)
                                        : const Icon(Icons.visibility)),
                              ),
                              obscureText: controller.isShowPassword.value,
                              suffixConstraints:
                                  const BoxConstraints(maxHeight: 36),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppStrings.emptyInputFieldMsg;
                                } else if (value.length < 8) {
                                  return AppStrings.passwordMustBe8Digit;
                                }
                                return null;
                              },
                            ),
                          ),
                          AppSpace.spaceH10,
                          CustomInputHeader(header: 'Confirm Password'),
                          AppSpace.spaceH6,
                          Obx(
                            () => CustomTextFormField(
                              obscureText:
                                  controller.isShowPasswordConfirm.value,
                              controller: controller.confirmPasswordCTL,
                              //  suffixIc:const Icon(Icons.remove_red_eye),
                              textInputType: TextInputType.text,
                              suffix: InkWell(
                                onTap: () {
                                  controller.isShowPasswordConfirm.value =
                                      !controller.isShowPasswordConfirm.value;
                                },
                                child: Container(
                                  child: controller.isShowPasswordConfirm.value
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility)

                                  /*   CustomImageView(
                                                  svgPath: controller
                                                          .isShowPassword.value
                                                      ? ImageConstant.imgEye
                                                      : ImageConstant.imgEye)*/
                                  ,
                                ),
                              ),
                              suffixConstraints:
                                  const BoxConstraints(maxHeight: 36),

                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppStrings.emptyInputFieldMsg;
                                } else if (value.length < 8) {
                                  return AppStrings.passwordMustBe8Digit;
                                }
                                return null;
                              },
                            ),
                          ),
                          AppSpace.spaceH20,
                          InkWell(
                            onTap: () {
                              controller.registerControllerBTN();
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
                                "Register".toUpperCase(),
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white),
                              )),
                            ),
                          ),
                          AppSpace.spaceH10,
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: const Text(
                                    'Already have an account ? Log In',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),
                            ],
                          ),
                          AppSpace.spaceH10,
                        ],
                      ),
                    )),
              ),
            ),
            AppSpace.spaceH20,

            ///------------ Footer ----------
          ],
        ),
      ),
    );
  }
}
