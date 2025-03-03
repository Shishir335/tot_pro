import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tot_pro/utils/data/core/values/app_helper.dart';
import 'package:tot_pro/utils/data/custom_text_form_field.dart';
import 'package:tot_pro/screens/join_us/controllers/join_controller.dart';
import 'package:tot_pro/screens/join_us/views/category_widget.dart';
import 'package:tot_pro/screens/join_us/views/image_picker.dart';
import 'package:tot_pro/components/app_bar.dart';
import 'package:tot_pro/components/floating_button.dart';

class JoinUsView extends StatelessWidget {
  JoinUsView({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JoinController>(builder: (controller) {
      return Stack(children: [
        Scaffold(
            backgroundColor: Colors.grey.shade200,
            appBar: const CustomAppBar(title: 'Join us'),
            body: Container(
                height: MediaQuery.of(context).size.height,
                color: Colors.grey.shade300,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Form(
                            key: formKey,
                            child: Column(children: [
                              CustomTextFormField(
                                  title: context.tr('Name'),
                                  controller: controller.name,
                                  textInputType: TextInputType.text,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return context
                                          .tr('Please enter your name');
                                    }
                                    return null;
                                  }),
                              CustomTextFormField(
                                  title: context.tr('Email'),
                                  controller: controller.email,
                                  textInputType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return context
                                          .tr('Please enter your email');
                                    }
                                    return null;
                                  }),
                              CustomTextFormField(
                                  title: context.tr('Phone'),
                                  controller: controller.phone,
                                  textInputType: TextInputType.phone,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return context
                                          .tr('Please enter your phone');
                                    }
                                    return null;
                                  }),
                              CustomTextFormField(
                                  title: context.tr('Address First Line'),
                                  controller: controller.addressFirstLine,
                                  textInputType: TextInputType.text,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return context.tr(
                                          'Please enter your address first line');
                                    }
                                    return null;
                                  }),
                              CustomTextFormField(
                                  title: context.tr('Address Second Line'),
                                  controller: controller.addressSecondLine,
                                  textInputType: TextInputType.text,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return context.tr(
                                          'Please enter your address second line');
                                    }
                                    return null;
                                  }),
                              CustomTextFormField(
                                  title: context.tr('Address Third Line'),
                                  controller: controller.addressThirdLine,
                                  textInputType: TextInputType.text,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return context.tr(
                                          'Please enter your address third line');
                                    }
                                    return null;
                                  }),
                              CustomTextFormField(
                                  title: context.tr('Town'),
                                  controller: controller.town,
                                  textInputType: TextInputType.text,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return context
                                          .tr('Please enter your town');
                                    }
                                    return null;
                                  }),
                              CustomTextFormField(
                                  title: context.tr('Postcode'),
                                  controller: controller.postcode,
                                  textInputType: TextInputType.text,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return context
                                          .tr('Please enter your postcode');
                                    }
                                    return null;
                                  }),
                              const SizedBox(height: 20),
                              CategoryWidget(
                                  selectedCategories:
                                      controller.selectedCategories,
                                  onChanged: (data) {
                                    controller.changeSelectedCategory(data);
                                  }),
                              const SizedBox(height: 20),
                              const CVPicker(),
                              const SizedBox(height: 20),
                            ]),
                          ),
                        ),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                )),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingButton(
                title: context.tr('SUBMIT'),
                onTap: () {
                  if (controller.selectedCategories.isEmpty) {
                    Helpers.snackbarForErorr(
                        titleText: 'Alert', bodyText: 'Select category');
                  } else if (controller.cv != null) {
                    Helpers.snackbarForErorr(
                        titleText: 'Alert', bodyText: 'Add CV');
                  } else {
                    if (formKey.currentState!.validate()) {
                      controller.joinUs(context);
                    }
                  }
                })),
        // if (controller.isLoading) showLoader(msg: 'Please wait')
      ]);
    });
  }
}
