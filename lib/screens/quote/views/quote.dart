import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tot_pro/utils/data/custom_text_form_field.dart';
import 'package:tot_pro/utils/data/helper.dart';
import 'package:tot_pro/screens/quote/controllers/quote_controller.dart';
import 'package:tot_pro/components/app_bar.dart';
import 'package:tot_pro/components/floating_button.dart';

class QuoteView extends GetView<QuoteController> {
  QuoteView({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: CustomAppBar(title: context.tr('Request a quote')),
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
                                  return context.tr('Please enter your name');
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
                              title: context.tr('Phone'),
                              controller: controller.phone,
                              textInputType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return context.tr('Please enter your phone');
                                }
                                return null;
                              }),
                          CustomTextFormField(
                              title: context.tr('City'),
                              controller: controller.city,
                              textInputType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return context.tr('Please enter your city');
                                }
                                return null;
                              }),
                          CustomTextFormField(
                              title: context.tr('Address'),
                              controller: controller.address,
                              textInputType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return context
                                      .tr('Please enter your address');
                                }
                                return null;
                              }),
                          CustomTextFormField(
                              title: context.tr('Details'),
                              controller: controller.details,
                              textInputType: TextInputType.text,
                              maxLines: 5,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return context
                                      .tr('Please enter your details');
                                }
                                return null;
                              }),
                          const SizedBox(height: 20)
                        ]),
                      ),
                    ),
                    const SizedBox(height: 40)
                  ],
                ),
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingButton(
              title: context.tr('SUBMIT'),
              onTap: () {
                if (formKey.currentState!.validate()) {
                  controller.requestQuote();
                }
              })),
      if (controller.isLoading) showLoader(msg: context.tr('Please wait'))
    ]);
  }
}
