import 'package:flutter/material.dart';

import '../core/colors.dart';

class ExpenseTextFormField extends StatelessWidget {
  final String? hintText;
  final IconData? icon;
  final IconData? suffixIcon;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final void Function()? onSuffixIconTap;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(PointerDownEvent)? onTapOutside;
  final TextInputType? keyboardType;
  const ExpenseTextFormField(
      {super.key,
      this.hintText,
      this.icon,
      this.suffixIcon,
      this.onSuffixIconTap,
      this.focusNode,
      this.controller,
      this.validator,
      this.onSaved,
      this.onTapOutside,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder kOutlineInputBorder(Color color) => OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 1,
            color: color,
          ),
        );
    return TextFormField(
      style: const TextStyle(
        color: CustomColors.background4,
      ),
      controller: controller,
      validator: validator,
      onSaved: onSaved,
      focusNode: focusNode,
      onTapOutside: onTapOutside,
      keyboardType: keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      cursorColor: CustomColors.background4,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        prefixIcon: Icon(
          icon,
          size: 18,
          color: CustomColors.background4,
        ),
        suffixIcon: InkWell(
          onTap: onSuffixIconTap,
          child: Icon(
            suffixIcon,
            size: 22,
            color: CustomColors.background4,
          ),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: CustomColors.background4,
        ),
        fillColor: CustomColors.background1,
        filled: true,
        errorStyle: const TextStyle(
          color: CustomColors.background4,
        ),
        enabledBorder: kOutlineInputBorder(CustomColors.background4),
        focusedBorder: kOutlineInputBorder(CustomColors.background4),
        errorBorder: kOutlineInputBorder(CustomColors.background4),
        focusedErrorBorder: kOutlineInputBorder(CustomColors.background4),
      ),
    );
  }
}
