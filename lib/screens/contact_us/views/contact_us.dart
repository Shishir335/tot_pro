import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tot_pro/utils/data/custom_text_form_field.dart';
import 'package:tot_pro/utils/data/helper.dart';
import 'package:tot_pro/screens/contact_us/controllers/contact_us_controller.dart';
import 'package:tot_pro/components/app_bar.dart';
import 'package:tot_pro/components/floating_button.dart';

class ContactUsView extends GetView<ContactUsController> {
  const ContactUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: const CustomAppBar(title: 'Contact us'),
          body: Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.grey.shade300,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(children: [
                    CustomTextFormField(
                        title: context.tr('First name'),
                        controller: controller.firstName,
                        textInputType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return context.tr('Please enter your first name');
                          }
                          return null;
                        }),
                    CustomTextFormField(
                        title: context.tr('Last name'),
                        controller: controller.lastName,
                        textInputType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return context.tr('Please enter your last name');
                          }
                          return null;
                        }),
                    CustomTextFormField(
                        title: context.tr('Email'),
                        controller: controller.email,
                        textInputType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return context.tr('Please enter your email');
                          }
                          return null;
                        }),
                    CustomTextFormField(
                        title: context.tr('Message'),
                        controller: controller.message,
                        textInputType: TextInputType.text,
                        maxLines: 5,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return context.tr('Please enter your review');
                          }
                          return null;
                        }),
                    const SizedBox(height: 100)
                  ]),
                ),
              )),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingButton(
              title: context.tr('SUBMIT'),
              onTap: () {
                controller.contactUs();
              })),
      if (controller.isLoading) showLoader(msg: context.tr('Please wait'))
    ]);
  }
}
