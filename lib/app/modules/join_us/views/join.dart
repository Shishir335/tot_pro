import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tot_pro/app/modules/home/controllers/submit_edge_controller.dart';

class JoinUsView extends GetView<SubmitEdgeController> {
  const JoinUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('Join Us', style: TextStyle(color: Colors.white))),
      body: Container(
          color: Colors.grey.shade300,
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0)),
    );
  }
}
