import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tot_pro/app/modules/home/controllers/submit_edge_controller.dart';
import 'package:tot_pro/components.dart/app_bar.dart';

class JoinUsView extends GetView<SubmitEdgeController> {
  const JoinUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: const CustomAppBar(title: 'Join Us'),
        body: Container(color: Colors.grey.shade300));
  }
}
