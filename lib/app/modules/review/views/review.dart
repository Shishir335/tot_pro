import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:tot_pro/app/modules/home/controllers/submit_edge_controller.dart';
import 'package:tot_pro/components.dart/app_bar.dart';

class ReviewView extends GetView<SubmitEdgeController> {
  const ReviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: const CustomAppBar(title: 'Leave a Review'),
        body: Container(color: Colors.grey.shade300));
  }
}
