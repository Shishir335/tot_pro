import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tot_pro/app/data/custom_text_form_field.dart';
import 'package:tot_pro/app/data/helper.dart';
import 'package:tot_pro/app/modules/contact_us/controllers/contact_us_controller.dart';
import 'package:tot_pro/components.dart/app_bar.dart';
import 'package:tot_pro/components.dart/floating_button.dart';

class ContactUsView extends GetView<ContactUsController> {
  const ContactUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: const CustomAppBar(title: 'Leave a Review'),
          body: Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.grey.shade300,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(children: [
                    CustomTextFormField(
                        title: 'First name',
                        controller: controller.firstName,
                        textInputType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        }),
                    CustomTextFormField(
                        title: 'Last name',
                        controller: controller.lastName,
                        textInputType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        }),
                    CustomTextFormField(
                        title: 'Email',
                        controller: controller.email,
                        textInputType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        }),
                    CustomTextFormField(
                        title: 'Message',
                        controller: controller.message,
                        textInputType: TextInputType.text,
                        maxLines: 5,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your review';
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
              title: 'SUBMIT',
              onTap: () {
                controller.contactUs();
              })),
      if (controller.isLoading) showLoader(msg: 'Please wait')
    ]);
  }
}
