import 'package:easy_localization/easy_localization.dart';
import 'package:field_suggestion/field_suggestion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tot_pro/components/app_bar.dart';
import 'package:tot_pro/utils/data/core/values/app_colors.dart';
import 'package:tot_pro/utils/data/core/values/app_strings.dart';
export 'package:get/get.dart';
import '../../../models/address_model.dart';
import '../../../utils/data/core/values/app_assets.dart';
import '../../../utils/data/core/values/app_space.dart';
import '../../../utils/data/customIntputHeader.dart';
import '../../../utils/data/custom_text_form_field.dart';
import '../controllers/user_profile_controller.dart';

class UserProfileView extends GetView<UserProfileController> {
  const UserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: CustomAppBar(title: context.tr('User Profile')),
      body: Container(
        child: Stack(
          children: [
            Container(
                height: 150,
                padding: const EdgeInsets.only(top: 0, bottom: 30),
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
                child: registerUI(context))
          ],
        ),
      ),
    );
  }

  registerUI(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            AppSpace.spaceH12,
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: Form(
                    key: controller.userProfileFormKey,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomInputHeader(header: context.tr('Name')),
                          AppSpace.spaceH6,
                          CustomTextFormField(
                            hintText: context.tr('Name'),
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
                          CustomInputHeader(header: context.tr('Company Name')),
                          AppSpace.spaceH6,
                          CustomTextFormField(
                            controller: controller.companyCTL,
                            textInputType: TextInputType.text,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppStrings.emptyInputFieldMsg;
                              }
                              return null;
                            },
                          ),
                          AppSpace.spaceH10,
                          CustomInputHeader(
                              header: context.tr('Mobile Number')),
                          AppSpace.spaceH6,
                          CustomTextFormField(
                            controller: controller.mobileCTL,
                            textInputType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppStrings.emptyInputFieldMsg;
                              }
                              return null;
                            },
                          ),
                          AppSpace.spaceH10,
                          CustomInputHeader(
                              header: context.tr('Address First Line')),
                          AppSpace.spaceH6,

                          ///----------- Finder Address --------
                          /*        FinderAddress(controller:controller,
                              address:controller.addressFirstLineCTL.text),
                          */
                          Obx(
                            () => FieldSuggestion<AddressModel>.network(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              inputDecoration: InputDecoration(
                                fillColor: controller.isReadOnly.value
                                    ? Colors.red.shade50
                                    : Colors.white10,

                                filled: true,
                                hintText: controller.firstAddress.value,
                                //controller.addressFirstLineCTL.text,
                                isDense: true,
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    //color: theme.colorScheme.onPrimaryContainer,
                                    width: 1,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    // color: theme.colorScheme.onPrimaryContainer,
                                    width: 1,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    //color: theme.colorScheme.onPrimaryContainer,
                                    width: 1,
                                  ),
                                ),
                                errorStyle: const TextStyle(color: Colors.red),
                              ),
                              future: (input) => controller.shouldSearch
                                  ? controller.addressLineOneController.text
                                              .length >
                                          1
                                      ? controller.searchAddress(input)
                                      : controller.returnEmptyFutureData()
                                  : controller.returnEmptyFutureData(),
                              textController:
                                  controller.addressLineOneController,
                              boxController: controller.boxController,
                              sizeByItem: 10,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return context.tr('Please enter address!');
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
                                        controller.addressLineOneController
                                            .text = result[index].suggestion!;

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
                                      child: Card(
                                          elevation: 0.2,
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 5),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              result[index].suggestion!,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                          )),
                                    );
                                  },
                                );
                              },
                            ),
                          ),

                          ///------------- End Finder address -------
                          AppSpace.spaceH10,
                          CustomInputHeader(
                              header: context.tr('Address Second Line')),
                          AppSpace.spaceH6,
                          CustomTextFormField(
                            // fillColor: controller.isReadOnly.value ?Colors.teal.shade50:Colors.white10,
                            isReadOnly: true,
                            //controller.isReadOnly.value,

                            // width: 185,
                            controller: controller.addressSecondLineCTL,
                            hintText: context.tr("Address Second Line"),
                            textInputType: TextInputType.text,
                            validator: (value) {
                              return null;
                            },
                          ),
                          AppSpace.spaceH10,
                          CustomInputHeader(
                              header: context.tr('Address Third Line')),
                          AppSpace.spaceH6,
                          CustomTextFormField(
                            fillColor: controller.isReadOnly.value
                                ? Colors.teal.shade50
                                : Colors.white10,
                            isReadOnly: true,
                            //controller.isReadOnly.value,

                            //  width: 185,
                            controller: controller.addressThirdLineCTL,
                            hintText: context.tr("Address Third Line"),
                          ),
                          AppSpace.spaceH10,
                          CustomInputHeader(header: context.tr('Town')),
                          AppSpace.spaceH6,
                          CustomTextFormField(
                            isReadOnly: true,
                            controller: controller.townCTL,
                            textInputType: TextInputType.text,
                            fillColor: controller.isReadOnly.value
                                ? Colors.red.shade50
                                : Colors.white10,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppStrings.emptyInputFieldMsg;
                              }
                              return null;
                            },
                          ),
                          AppSpace.spaceH10,
                          CustomInputHeader(header: context.tr('Postcode')),
                          AppSpace.spaceH6,
                          CustomTextFormField(
                            isReadOnly: true,
                            controller: controller.postCodeCTL,
                            textInputType: TextInputType.text,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppStrings.emptyInputFieldMsg;
                              }
                              return null;
                            },
                          ),
                          AppSpace.spaceH10,
                          CustomInputHeader(header: context.tr('Email')),
                          AppSpace.spaceH6,
                          CustomTextFormField(
                            isReadOnly: true,
                            controller: controller.mailCTL,
                            textInputType: TextInputType.text,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppStrings.emptyInputFieldMsg;
                              }
                              return null;
                            },
                          ),

                          ///----------- SUBMIT ------------
                          AppSpace.spaceH20,
                          InkWell(
                            onTap: () {
                              if (controller.userProfileFormKey.currentState!
                                  .validate()) {
                                controller.updateProfileUpdate();
                              }
                            },
                            child: Container(
                              width: double.maxFinite,
                              height: 50,
                              decoration: BoxDecoration(
                                color: AppColors.black,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                  child: Text(
                                context.tr("Submit").toUpperCase(),
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white),
                              )),
                            ),
                          ),

                          AppSpace.spaceH20,
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

class FinderAddress extends StatelessWidget {
  final UserProfileController controller;
  final String? address;
  const FinderAddress(
      {super.key, required this.controller, required this.address});

  @override
  Widget build(BuildContext context) {
    return searchAddress(context);
  }

  searchAddress(BuildContext context) {
    return FieldSuggestion<AddressModel>.network(
      inputDecoration: InputDecoration(
        fillColor:
            controller.isReadOnly.value ? Colors.red.shade50 : Colors.white10,

        filled: true,
        hintText: controller.addressFirstLineCTL.text,
        isDense: true,
        contentPadding: const EdgeInsets.all(20),
        // fillColor: appTheme.teal50, //old appTheme.gray200,
        // filled: filled,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            //color: theme.colorScheme.onPrimaryContainer,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            // color: theme.colorScheme.onPrimaryContainer,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            //color: theme.colorScheme.onPrimaryContainer,
            width: 1,
          ),
        ),

        errorStyle: const TextStyle(color: Colors.red),
      ),
      future: (input) => controller.shouldSearch
          ? controller.addressLineOneController.text.length > 1
              ? controller.searchAddress(input)
              : controller.returnEmptyFutureData()
          : controller.returnEmptyFutureData(),
      textController: controller.addressLineOneController,
      boxController: controller.boxController,
      sizeByItem: 10,
      validator: (value) {
        if (value!.isEmpty) {
          return context.tr('Please enter address!');
        }
        return null;
      },
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
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
                  controller
                      .getAndSetAddressDetails(result[index].urls!.udprn!);
                }
              },
              child: Card(
                  elevation: 0.2,
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      result[index].suggestion!,
                      style: const TextStyle(color: Colors.black),
                    ),
                  )),
            );
          },
        );
      },
    );
  }
}
