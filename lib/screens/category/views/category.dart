import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:tot_pro/utils/data/core/values/app_url.dart';
import 'package:tot_pro/screens/category/controllers/category_controller.dart';
import 'package:tot_pro/components/app_bar.dart';

class CategoryView extends GetView<CategoryController> {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(builder: (context) {
      return Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: const CustomAppBar(title: 'Categories'),
          body: Container(
              color: Colors.grey.shade300,
              child: GridView.builder(
                  itemCount: controller.categories.length,
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    var data = controller.categories[index];
                    return Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                  ApiURL.categoryImageUrl + data.image!),
                              const SizedBox(height: 5),
                              Text(data.name!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18))
                            ]));
                  })));
    });
  }
}
