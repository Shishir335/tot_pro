import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:tot_pro/app/data/core/values/app_space.dart';
import 'package:tot_pro/app/data/customIntputHeader.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.title,
    this.alignment,
    this.width,
    this.margin,
    this.isReadOnly = false,
    this.controller,
    this.focusNode,
    this.autofocus = false,
    this.textStyle,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.hintText,
    this.hintStyle,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixIc,
    this.suffixConstraints,
    this.contentPadding,
    this.borderDecoration,
    this.boxHight,
    this.fillColor,
    this.filled = true,
    this.onChanged,
    this.custformatter,
    this.validator,
  });

  final String? title;

  final Alignment? alignment;

  final double? width;

  final EdgeInsetsGeometry? margin;

  final TextEditingController? controller;

  final FocusNode? focusNode;

  final bool? autofocus;

  final TextStyle? textStyle;

  final bool? obscureText;

  final TextInputAction? textInputAction;

  final TextInputType? textInputType;

  final int? maxLines;
  final double? boxHight;

  final String? hintText;

  final TextStyle? hintStyle;
  final bool? isReadOnly;

  final Widget? prefix;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;
  final Widget? suffixIc;

  final BoxConstraints? suffixConstraints;

  final EdgeInsets? contentPadding;

  final InputBorder? borderDecoration;

  final Color? fillColor;

  final bool? filled;

  final FormFieldValidator<String>? validator;
  final Function? onChanged;
  final List<TextInputFormatter>? custformatter;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: textFormFieldWidget,
          )
        : textFormFieldWidget;
  }

  Widget get textFormFieldWidget => Container(
        padding: const EdgeInsets.only(left: 0),
        margin: const EdgeInsets.symmetric(vertical: 0),
        width: width ?? double.maxFinite,
        //  height: 60,
        alignment: Alignment.center,
        //  height:  70,//boxHight??50.0,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null)
              Column(children: [
                AppSpace.spaceH6,
                CustomInputHeader(header: title),
                AppSpace.spaceH6,
              ]),
            TextFormField(
              readOnly: isReadOnly ?? false,
              controller: controller,
              // focusNode: focusNode ?? FocusNode(),
              //  autofocus: autofocus!,
              onChanged: (v) => onChanged,
              inputFormatters: custformatter ?? [],
              obscureText: obscureText!,
              textInputAction: textInputAction,
              keyboardType: textInputType,
              maxLines: maxLines ?? 1,
              decoration: decoration,
              validator: validator,
              scrollPadding: const EdgeInsets.symmetric(horizontal: 10),
            ),
          ],
        ),
      );
  InputDecoration get decoration => InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        suffix: suffix,
        suffixIcon: suffixIc,
        hintText: hintText ?? '',
        filled: true,
        fillColor: true ? Colors.red.shade50.withOpacity(0.6) : Colors.black12,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
      );
}
