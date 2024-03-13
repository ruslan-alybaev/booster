import 'package:booster/data/measurement_cubit.dart';
import 'package:booster/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CustomDropdownButton extends StatefulWidget {
   TextEditingController? measurementsController;
 CustomDropdownButton({
    Key? key,
    required this.measurementsController,
  }) : super(key: key);

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();

}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
    bool _hasFocus = false;
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeasurementCubit, List<Map<String, dynamic>>>(
      builder: (context, state) {       
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            DropdownButtonFormField<String>(
              isExpanded: true,
              focusNode: FocusNode(),
              itemHeight: 60,
              controller: widget.measurementsController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 15),
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
                label: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
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
                fillColor: _hasFocus ? AppColors.white : AppColors.tfBGColor,
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
              onChanged: (selectedValue) {
                // Обновляем значение в контроллере measurementsController
                widget.measurementsController!.text = selectedValue!;
                setState(() {
                  this.selectedValue = selectedValue; // Обновляем выбранное значение
                });
              },
              onTap: () {
                setState(() {
                  _hasFocus = true;
                });
              },
              selectedItemBuilder: (BuildContext context) {
                return state.map<Widget>((measurement) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      measurement['name'],
                      style: TextStyle(
                        fontSize: 14,
                        color: measurement['id'].toString() == selectedValue
                            ? AppColors.textColor
                            : AppColors.white, // Черный цвет выбранного элемента списка
                      ),
                    ),
                  );
                }).toList();
              },
              icon: Padding(
                padding: const EdgeInsets.only(right: 15),
                child: SvgPicture.asset("assets/images/Dropdown_arrow.svg"),
              ),
              iconSize: 30,
              dropdownColor: AppColors.textColor,
            ),
          ],
        );
      },
    );
  }
}
