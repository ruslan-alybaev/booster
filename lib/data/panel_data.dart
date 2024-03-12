import 'package:flutter/material.dart';

class PanelDataMaterial {
  TextEditingController measurementsController;
  TextEditingController nameMaterialController;
  TextEditingController quantityController;

  PanelDataMaterial({
    required this.measurementsController,
    required this.nameMaterialController,
    required this.quantityController,
  });
}

class PanelDataAccessories {
  TextEditingController measurementsController;
  TextEditingController nameAccessoriesController;
  TextEditingController quantityController;

  PanelDataAccessories({
    required this.measurementsController,
    required this.nameAccessoriesController,
    required this.quantityController,
  });
}
