
import 'package:booster/data/measurement_cubit.dart';
import 'package:booster/presentation/theme/app_colors.dart';
import 'package:dropdown_button3/dropdown_button3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDropdownButton extends StatefulWidget {
  final TextEditingController? measurementsController;
  final Function()? onDropdownReset;
  const CustomDropdownButton({super.key, this.measurementsController, this.onDropdownReset,});

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {

  bool _hasFocus = false;
  String? selectedValue;

  void resetSelectedValue() {
    setState(() {
      selectedValue = null;
    });
  }
  

  @override
  Widget build(BuildContext context) {
    final measurementCubit = BlocProvider.of<MeasurementCubit>(context);
    return BlocBuilder<MeasurementCubit, List<Map<String, dynamic>>>(
        bloc: measurementCubit,
        builder: (context, measurements) {
          return DropdownButtonFormField2(
            focusNode: FocusNode(),
            buttonHeight: 60,
            dropdownDecoration: BoxDecoration(
             borderRadius: BorderRadius.circular(15),
             color: AppColors.textColor
            ),
            controller: widget.measurementsController,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(                  
                borderRadius: BorderRadius.circular(15),
              ),
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
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  "Ед. измерения*",
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
            isExpanded: true,
            items: measurements
                .map((measurement) => DropdownMenuItem<String>(
                      value: measurement["id"],
                      child: Text(
                        measurement["name"],
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 14,
                        ),
                      ),
                    ))
                .toList(),
            onChanged: (selectedValue) {
              widget.measurementsController?.text = selectedValue!;
              setState(() {
                this.selectedValue = selectedValue;
                _hasFocus = true;
              });
            },
            selectedItemBuilder: (BuildContext context) {
              return measurements.map<Widget>((measurement) {
                return Text(
                  measurement['name'],
                  style: TextStyle(
                    fontSize: 14,
                    color: measurement['id'].toString() == selectedValue
                        ? AppColors.textColor
                        :  AppColors.white// Черный цвет выбранного элемента списка
                  ),
                );
              }).toList();
            },

          );
        });
  }
}
