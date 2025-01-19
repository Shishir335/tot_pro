import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:tot_pro/app/data/core/values/app_space.dart';
import 'package:tot_pro/app/data/customIntputHeader.dart';
import 'package:tot_pro/app/data/helper.dart';
import 'package:tot_pro/components/app_bar.dart';
import 'package:tot_pro/app/data/custom_text_form_field.dart';
import 'package:tot_pro/app/modules/review/controllers/review_controller.dart';
import 'package:tot_pro/components/floating_button.dart';

class ReviewView extends GetView<ReviewController> {
  const ReviewView({super.key});

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
                            return 'Please enter your email';
                          }
                          return null;
                        }),
                    CustomTextFormField(
                        title: 'Review',
                        controller: controller.review,
                        textInputType: TextInputType.text,
                        maxLines: 5,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your review';
                          }
                          return null;
                        }),
                    AppSpace.spaceH20,
                    Row(children: [
                      CustomInputHeader(header: 'Rate Us: '),
                      for (int i = 0; i < 5; i++)
                        InkWell(
                            onTap: () {
                              controller.changeStar(i);
                            },
                            child: Icon(Icons.star_rounded,
                                color: i < controller.stars
                                    ? Colors.amber
                                    : Colors.grey,
                                size: 40))
                    ]),
                    const SizedBox(height: 100)
                  ]),
                ),
              )),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingButton(
              title: 'SUBMIT',
              onTap: () {
                controller.submitReview();
              })),
      if (controller.isLoading) showLoader(msg: 'Please wait')
    ]);
  }
}
