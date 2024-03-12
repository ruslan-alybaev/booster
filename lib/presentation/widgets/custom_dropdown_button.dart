import 'package:booster/data/measurement_cubit.dart';
import 'package:booster/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CustomDropdownButton extends StatelessWidget {
  final TextEditingController measurementsController;

  const CustomDropdownButton({
    Key? key,
    required this.measurementsController,
  }) : super(key: key);

  void clearField() {
    measurementsController.clear(); // Очищаем поле контроллера
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeasurementCubit, List<Map<String, dynamic>>>(
      builder: (context, state) {
        return DropdownButtonFormField<String>(
          controller: measurementsController,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.zero,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: AppColors.borderColor),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: AppColors.borderColor),
            ),
            errorText: null, // Update error text as needed
            label: const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                "Ед. измерения *",
                style: TextStyle(
                  color: AppColors.hintTextColor,
                  backgroundColor: Colors.transparent,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            fillColor: AppColors.tfBGColor,
            filled: true,
          ),
          items: state.map<DropdownMenuItem<String>>((measurement) {
            return DropdownMenuItem<String>(
              value: measurement['id'].toString(),
              child: Text(
                measurement['name'],
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.white, // Белый цвет элементов в списке
                ),
              ),
            );
          }).toList(),
          selectedItemBuilder: (BuildContext context) {
            return state.map<Widget>((measurement) {
              return Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  measurement['name'],
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textColor, // Черный цвет выбранного элемента списка
                  ),
                ),
              );
            }).toList();
          },
          onChanged: (selectedValue) {
            // Обновляем значение в контроллере measurementsController
            measurementsController.text = selectedValue!;
          },
          icon: Padding(
            padding: const EdgeInsets.only(right: 15),
            child: SvgPicture.asset("assets/images/Dropdown_arrow.svg"),
          ),
          iconSize: 30,
          dropdownColor: AppColors.textColor,
        );
      },
    );
  }
}
