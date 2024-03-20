
import 'package:flutter/material.dart';
import 'package:booster/presentation/theme/app_colors.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final String? labelText;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  const CustomTextField({
    super.key,
    required this.labelText,
    required this.controller,
    this.onChanged,
    this.onEditingComplete,
    this.keyboardType,
    this.inputFormatters,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _hasFocus = false;
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: FocusNode(),
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: const TextStyle(
            color: AppColors.hintTextColor,
            fontSize: 16,
            fontWeight: FontWeight.w400),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.borderColor, width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.borderColor, width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        errorText: _errorText,
        fillColor: _hasFocus ? AppColors.white : AppColors.tfBGColor,
        filled: true,
      ),
      onChanged: (value) {
        print(value);
      },
      onTap: () {
        setState(() {
          _hasFocus = true;
        });
      },
    );
  }
}
