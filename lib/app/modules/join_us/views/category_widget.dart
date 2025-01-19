import 'package:flutter/material.dart';
import 'package:tot_pro/app/modules/account_delete_request/views/account_delete_request_view.dart';
import 'package:tot_pro/app/modules/category/controllers/category_controller.dart';
import 'package:tot_pro/models/category.dart';

class CategoryWidget extends StatefulWidget {
  final List<Data> selectedCategories;
  final Function(List<Data>) onChanged;
  const CategoryWidget(
      {super.key, required this.selectedCategories, required this.onChanged});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  final List<Data> categories = [];

  @override
  void initState() {
    Get.put(CategoryController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(builder: (controller) {
      return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text('Select category',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
            const SizedBox(height: 10),
            Wrap(children: [
              for (var item in controller.categories)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                          height: 20,
                          width: 20,
                          child: Checkbox(
                              value: widget.selectedCategories.contains(item),
                              onChanged: (value) {
                                addToCategories(item);
                                widget.onChanged(categories);
                              })),
                      const SizedBox(width: 5),
                      Text(item.name!)
                    ],
                  ),
                )
            ])
          ],
        ),
      );
    });
  }

  addToCategories(Data value) {
    int index = categories.indexWhere((element) => element.id == value.id);
    print('index $index');

    if (index == -1) {
      categories.add(value);
    } else {
      categories.removeWhere((element) => element.id == value.id);
    }
    setState(() {});
  }
}
