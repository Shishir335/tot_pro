import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tot_pro/app/data/custom_text_form_field.dart';
import 'package:tot_pro/app/data/helper.dart';
import 'package:tot_pro/app/modules/join_us/controllers/join_controller.dart';
import 'package:tot_pro/components.dart/app_bar.dart';
import 'package:tot_pro/components.dart/floating_button.dart';

class JoinUsView extends GetView<JoinController> {
  const JoinUsView({super.key});

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
                        title: 'Name',
                        controller: controller.name,
                        textInputType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
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
                        title: 'Phone',
                        controller: controller.phone,
                        textInputType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone';
                          }
                          return null;
                        }),
                    CustomTextFormField(
                        title: 'Address First Line',
                        controller: controller.addressFirstLine,
                        textInputType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your address first line';
                          }
                          return null;
                        }),
                    CustomTextFormField(
                        title: 'Address Second Line',
                        controller: controller.addressSecondLine,
                        textInputType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your address second line';
                          }
                          return null;
                        }),
                    CustomTextFormField(
                        title: 'Address Third Line',
                        controller: controller.addressThirdLine,
                        textInputType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your address third line';
                          }
                          return null;
                        }),
                    CustomTextFormField(
                        title: 'Town',
                        controller: controller.town,
                        textInputType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your town';
                          }
                          return null;
                        }),
                    CustomTextFormField( 
                        title: 'Postcode',
                        controller: controller.postcode,
                        textInputType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your postcode';
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
                controller.joinUs();
              })),
      if (controller.isLoading) showLoader(msg: 'Please wait')
    ]);
  }
}
