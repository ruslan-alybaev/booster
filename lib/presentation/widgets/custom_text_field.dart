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
  final int? maxLines;

  const CustomTextField({
    super.key,
    this.labelText,
    this.controller,
    this.onChanged,
    this.onEditingComplete,
    this.keyboardType,
    this.inputFormatters,
    this.maxLines,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String? _errorText;
  FocusNode _focusNode = FocusNode();
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChange);
    widget.controller?.addListener(_handleControllerChange); // Добавлен слушатель для контроллера
    _updateFocusBasedOnText();
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    widget.controller?.removeListener(_handleControllerChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _hasFocus = _focusNode.hasFocus || widget.controller?.text.isNotEmpty == true;
    });
    if (!_focusNode.hasFocus) {
      // Поле потеряло фокус, проверяем его содержимое
      _updateErrorText();
    }
  }

  void _handleControllerChange() {
    setState(() {
      _hasFocus = widget.controller?.text.isNotEmpty == true;
    });
  }

  void _updateFocusBasedOnText() {
    setState(() {
      _hasFocus = widget.controller?.text.isNotEmpty == true;
    });
  }

  void _updateErrorText() {
    if (widget.controller?.text.isEmpty ?? true) {
      setState(() {
        _errorText = 'Это поле обязательно к заполнению';
      });
    } else {
      setState(() {
        _errorText = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: _focusNode,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      maxLines: widget.maxLines,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        labelText: widget.labelText,
        labelStyle: const TextStyle(
          color: AppColors.hintTextColor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.borderColor, width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        border: OutlineInputBorder(
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
        _updateFocusBasedOnText();
        widget.onChanged?.call(value);
      },
      onEditingComplete: () {
        _updateFocusBasedOnText();
        widget.onEditingComplete?.call();
      },
    );
  }
}
