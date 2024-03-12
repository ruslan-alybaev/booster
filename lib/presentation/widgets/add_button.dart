import 'package:booster/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final String buttonTitle;
  final void Function()? onPressed;
  const AddButton({
    super.key,
    required this.buttonTitle,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          padding:
             const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          backgroundColor: AppColors.enableButtonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          )),
      onPressed: onPressed, 
      child: Text(
        buttonTitle,
        style: const TextStyle(
          color: AppColors.white,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
