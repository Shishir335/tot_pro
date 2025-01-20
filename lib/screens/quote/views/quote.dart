import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tot_pro/utils/data/custom_text_form_field.dart';
import 'package:tot_pro/utils/data/helper.dart';
import 'package:tot_pro/screens/quote/controllers/quote_controller.dart';
import 'package:tot_pro/components/app_bar.dart';
import 'package:tot_pro/components/floating_button.dart';

class QuoteView extends GetView<QuoteController> {
  const QuoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: const CustomAppBar(title: 'Request a quote'),
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
                        title: 'City',
                        controller: controller.city,
                        textInputType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your city';
                          }
                          return null;
                        }),
                    CustomTextFormField(
                        title: 'Address',
                        controller: controller.address,
                        textInputType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your address';
                          }
                          return null;
                        }),
                    CustomTextFormField(
                        title: 'Details',
                        controller: controller.details,
                        textInputType: TextInputType.text,
                        maxLines: 5,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your details';
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
                controller.requestQuote();
              })),
      if (controller.isLoading) showLoader(msg: 'Please wait')
    ]);
  }
}
