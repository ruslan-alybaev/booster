import 'package:flutter/material.dart';
import 'package:booster/presentation/theme/app_colors.dart';

class DescriptionTextField extends StatefulWidget {
  final String? labelText;
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;

  const DescriptionTextField({
    Key? key,
    required this.labelText,
    required this.controller,
    this.onChanged,
    this.onEditingComplete,
  }) : super(key: key);

  @override
  _DescriptionTextFieldState createState() => _DescriptionTextFieldState();
}

class _DescriptionTextFieldState extends State<DescriptionTextField> {
  bool _hasFocus = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      focusNode: FocusNode(),
      maxLines: 8,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        labelText: widget.labelText,
        labelStyle: const TextStyle(
          color: AppColors.hintTextColor,
          fontSize: 16,
          fontWeight: FontWeight.w400
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.borderColor, width: 1),
          borderRadius: BorderRadius.circular(15),
        ), 
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.borderColor, width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.borderColor),
          borderRadius: BorderRadius.circular(15),
        ),
        fillColor: _hasFocus ? AppColors.white : AppColors.tfBGColor,
        filled: true,
      ),
      onTap: () {
        setState(() {
          _hasFocus = true;
        });
      },
      onChanged: (text) {
        if (text.isEmpty) {
          setState(() {
            _hasFocus = false;
          });
        } 
        widget.onChanged?.call(text);
      },
    );
  }
}
