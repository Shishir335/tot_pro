import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tot_pro/utils/data/core/values/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(context.tr(title)));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
