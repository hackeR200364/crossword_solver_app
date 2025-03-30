import 'package:flutter/material.dart';

import '../styles.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.hint,
    required this.keyboard,
    this.validator,
    required this.textEditingController,
    this.obscure,
    this.suffix,
    this.textCapitalization,
    this.focusNode,
  });

  final String hint;
  final TextInputType keyboard;
  final String? Function(String?)? validator;
  final TextEditingController textEditingController;
  final bool? obscure;
  final Widget? suffix;
  final TextCapitalization? textCapitalization;
  final FocusNode? focusNode;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final GlobalKey<FormFieldState> formFieldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
      obscureText: widget.obscure ?? false,
      key: formFieldKey,
      onChanged: ((value) {
        formFieldKey.currentState!.validate();
      }),
      controller: widget.textEditingController,
      style: TextStyle(color: AppColors.black, fontSize: 15),
      validator: widget.validator,
      keyboardType: widget.keyboard,
      cursorColor: AppColors.green,
      decoration: InputDecoration(
        suffixIcon: widget.suffix,
        contentPadding: EdgeInsets.all(15),
        hintText: widget.hint,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.black.withOpacity(0.1),
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.black.withOpacity(0.2),
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.green.withOpacity(0.7),
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.red,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
