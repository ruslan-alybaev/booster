import 'package:booster/presentation/widgets/clear_button.dart';
import 'package:booster/presentation/widgets/custom_dropdown_button.dart';
import 'package:booster/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateMaterialPanel extends StatefulWidget {
  final void Function()? onPressedDeleteButton;
  final TextEditingController? materialNameController;
  final TextEditingController? quantityController;
  final TextEditingController? measurementController;
  final String labelTextMaterial;
  final String labelTextQuantity;

  bool? isButtonEnabled;
  final VoidCallback? onDelete;


  CreateMaterialPanel({
    super.key,
    this.onPressedDeleteButton,
    required this.materialNameController,
    required this.quantityController,
    required this.measurementController,
    required this.labelTextMaterial,
    required this.labelTextQuantity,
    this.isButtonEnabled,
    this.onDelete,
  });

  @override
  State<CreateMaterialPanel> createState() => _CreateMaterialPanelState();
}

class _CreateMaterialPanelState extends State<CreateMaterialPanel> {
  @override
  void initState() {
    super.initState();
    widget.materialNameController?.addListener(updateButtonColor);
  }

  void updateButtonColor() {
    setState(() {
      widget.isButtonEnabled = widget.materialNameController?.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    widget.materialNameController?.removeListener(updateButtonColor);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                labelText: widget.labelTextMaterial,
                controller: widget.materialNameController,
                keyboardType: TextInputType.text,
              ),
            ),
            const SizedBox(width: 10),
            ClearButton(
              onTap: widget.isButtonEnabled ?? false
                  ? () {
                      widget.onDelete?.call();
                      widget.materialNameController?.clear();
                      widget.quantityController?.clear();
                      widget.measurementController?.clear();
                    }
                  : null,
              isActive: widget.isButtonEnabled,
            )
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                labelText: widget.labelTextQuantity,
                controller: widget.quantityController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: CustomDropdownButton(
                measurementsController: widget.measurementController,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
