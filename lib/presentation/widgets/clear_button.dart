import 'package:booster/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  final bool?
      isActive; // Добавляем параметр isActive для определения активности кнопки
  final void Function()? onTap;

  const RoundIconButton({
    required this.isActive,
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: isActive ?? false
              ? Border.all(
                  color: AppColors.enableButtonColor,
                )
              : Border.all(color: Colors.transparent),
          color: isActive ?? false
              ? AppColors.white
              : AppColors.disabledButtonColor,
        ),
        child: Icon(
          Icons.close,
          color:
              isActive ?? false ? AppColors.enableButtonColor : AppColors.white,
        ),
      ),
    );
  }
}
