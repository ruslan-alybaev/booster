import 'package:booster/data/measurement_cubit.dart';
import 'package:booster/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDropdownButton extends StatefulWidget {
  final TextEditingController? measurementsController;

  const CustomDropdownButton({
    super.key,
    this.measurementsController,
  });
  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  String selectedValue = '';

  @override
  Widget build(BuildContext context) {
    return Focus(
      child: BlocBuilder<MeasurementCubit, List<Map<String, dynamic>>>(
        builder: (context, measurementNames) {
          return DropdownMenu<Map<String, dynamic>>(
            inputDecorationTheme: InputDecorationTheme(
              fillColor: widget.measurementsController!.text.isEmpty
                  ? AppColors.tfBGColor
                  : AppColors.white,
              filled: true,
              contentPadding: const EdgeInsets.only(
                top: -10,
                bottom: -10,
                left: 10,
              ),
              labelStyle: const TextStyle(color: AppColors.hintTextColor),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: AppColors.disabledButtonColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                        color: AppColors.disabledButtonColor,
                        width: 1.0,
                      ),
              ),
            ),
            width: 185.0,
            trailingIcon: const Icon(Icons.arrow_drop_down),
            controller: widget.measurementsController,
            label: const Text(
              'Ед.измерения *',
              style: TextStyle(fontSize: 15),
            ),
            onSelected: (Map<String, dynamic>? selectedMeasurement) {
              if (selectedMeasurement != null) {
                setState(() {
                  selectedValue = selectedMeasurement['id'].toString();
                });
              }
            },
            menuStyle: MenuStyle(
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              )),
              backgroundColor: const MaterialStatePropertyAll(
                AppColors.textColor,
              ),
            ),
            dropdownMenuEntries:
                measurementNames.map<DropdownMenuEntry<Map<String, dynamic>>>(
              (measurement) {
                return DropdownMenuEntry<Map<String, dynamic>>(
                  value: measurement,
                  label: measurement['name'].toString(),
                  trailingIcon: measurement['name'] == 'метр'
                      ? const Icon(
                          Icons.arrow_drop_up,
                          color: Colors.white,
                        )
                      : null,
                  style: MenuItemButton.styleFrom(
                    foregroundColor: AppColors.white,
                    backgroundColor: AppColors.textColor,
                  ),
                );
              },
            ).toList(),
          );
        },
      ),
    );
  }
}
