import 'package:flutter/material.dart';

class FloatingButton extends StatelessWidget {
  final String? title;
  final void Function()? onTap;
  const FloatingButton({super.key, this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
          onTap: onTap,
          child: Container(
              width: double.maxFinite,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(10)),
              child: Center(
                  child: Text(title!,
                      style: const TextStyle(
                          fontSize: 18, color: Colors.white))))),
    );
  }
}
