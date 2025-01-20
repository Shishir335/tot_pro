import 'package:flutter/material.dart';

class CustomInputHeader extends StatelessWidget {
  String? header;
   CustomInputHeader({super.key, required this.header});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Text(
        header??'',
        style: TextStyle( color: Colors.grey.shade700),
      ),
    );
  }
}
