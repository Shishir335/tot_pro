import 'package:flutter/material.dart';

class CustomTitleKeyValue extends StatelessWidget {
  final titleKey;
  final titleValue;

  const CustomTitleKeyValue(
      {required this.titleKey, required this.titleValue, super.key});

  @override
  Widget build(BuildContext context) {
    return _customTitleKeyValue(titleKey, titleValue);
  }

  _customTitleKeyValue(String key, String value) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
              flex: 2,
              child: Text(
                key,
                maxLines: 1,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              )),
          Expanded(
            flex: 3,
            child: Text(' : $value',
                style: const TextStyle(
                    fontWeight: FontWeight.w400, color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
