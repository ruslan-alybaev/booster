import 'package:booster/data/panel_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:booster/presentation/theme/app_colors.dart';
import 'package:booster/presentation/widgets/add_button.dart';
import 'package:booster/presentation/widgets/create_material_panel.dart';
import 'package:booster/presentation/widgets/custom_text_field.dart';
import 'package:booster/presentation/widgets/description_field.dart';
import 'package:booster/repositories/create_material.dart';

class CreateArticleScreen extends StatefulWidget {
  const CreateArticleScreen({Key? key}) : super(key: key);

  @override
  State<CreateArticleScreen> createState() => _CreateArticleScreenState();
}

class _CreateArticleScreenState extends State<CreateArticleScreen> {
  final TextEditingController articleNumberController = TextEditingController();
  final TextEditingController articleDescriptionController =
      TextEditingController();

  final TextEditingController nameMaterialController = TextEditingController();
  final TextEditingController measurementsMaterialController =
      TextEditingController();
  final TextEditingController quantityMaterialController =
      TextEditingController();

  final TextEditingController nameAccessoriesController =
      TextEditingController();
  final TextEditingController measurementsAccessoriesController =
      TextEditingController();
  final TextEditingController quantityAccessoriesController =
      TextEditingController();

  final CreateMaterial createMaterial = CreateMaterial();

  List<CreateMaterialPanel> materialWidgets = [];
  List<CreateMaterialPanel> accessoriesWidgets = [];

  List<PanelDataMaterial> panelDataMaterialList = [];
  List<PanelDataAccessories> panelDataAccessoriesList = [];

  final GlobalKey panel1Key = GlobalKey();
  final GlobalKey panel2Key = GlobalKey();

  int materialPanelKeyCounter = 0;
  int furniturePanelKeyCounter = 0;

  bool isButtonActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 92,
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Booster",
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: SvgPicture.asset("assets/images/icon.svg"),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
            child: Center(
              child: Column(
                children: [
                  const Text(
                    "ИНФОРМАЦИЯ ОБ АРТИКУЛЕ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textColor,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    labelText: "Номер артикула *",
                    controller: articleNumberController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DescriptionTextField(
                    labelText: "Описание",
                    controller: articleDescriptionController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "МАТЕРИАЛ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textColor,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CreateMaterialPanel(
                    key: panel1Key,
                    materialNameController: nameMaterialController,
                    quantityController: quantityMaterialController,
                    measurementController: measurementsMaterialController,
                    labelTextMaterial: "Материал, цвет*",
                    labelTextQuantity: "Кол-во на ед. прод. *",
                    isButtonEnabled:
                        nameMaterialController.text.isNotEmpty ? true : false,
                    onPressedDeleteButton: () {
                      setState(() {
                        nameMaterialController.clear();
                        quantityMaterialController.clear();
                      });
                    },
                  ),

                  ...materialWidgets.asMap().entries.map((e) {
                    final index = e.key;
                    return CreateMaterialPanel(
                      materialNameController:
                          panelDataMaterialList[index].nameMaterialController,
                      quantityController:
                          panelDataMaterialList[index].quantityController,
                      measurementController:
                          panelDataMaterialList[index].measurementsController,
                      labelTextMaterial: "Материал, цвет*",
                      labelTextQuantity: "Кол-во на ед. прод. *",
                      isButtonEnabled: true,
                      onPressedDeleteButton: () {
                        setState(() {
                          materialWidgets.removeAt(index);
                          panelDataMaterialList.removeAt(index);
                        });
                      },
                    );
                  }),
                  // Создание новой панели материалов
                  AddButton(
                    buttonTitle: "+ материал",
                    onPressed: () {
                      setState(() {
                        final UniqueKey newPanelKey = UniqueKey();
                        TextEditingController materialNameController =
                            TextEditingController();
                        TextEditingController quantityController =
                            TextEditingController();
                        TextEditingController measurementController =
                            TextEditingController();

                        PanelDataMaterial newPanelData = PanelDataMaterial(
                          nameMaterialController: materialNameController,
                          quantityController: quantityController,
                          measurementsController: measurementController,
                        );

                        panelDataMaterialList.add(newPanelData);
                        materialWidgets.add(
                          CreateMaterialPanel(
                            key: newPanelKey,
                            materialNameController: materialNameController,
                            quantityController: quantityController,
                            measurementController: measurementController,
                            isButtonEnabled: true,
                            labelTextMaterial: "+ Материал",
                            labelTextQuantity: "Кол-во на ед. прод. *",
                          ),
                        );
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "ФУРНИТУРА",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textColor,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CreateMaterialPanel(
                    key: panel2Key,
                    materialNameController: nameAccessoriesController,
                    quantityController: quantityAccessoriesController,
                    measurementController: measurementsAccessoriesController,
                    labelTextMaterial: "Фурнитура *",
                    labelTextQuantity: "Кол-во на единицу *",
                    isButtonEnabled: nameAccessoriesController.text.isNotEmpty
                        ? true
                        : false,
                    onPressedDeleteButton: () {
                      setState(() {
                        nameAccessoriesController.clear();
                        quantityAccessoriesController.clear();
                        measurementsAccessoriesController.clear();
                      });
                    },
                  ),

                  ...accessoriesWidgets.asMap().entries.map((e) {
                    final index = e.key;
                    return CreateMaterialPanel(
                      materialNameController: panelDataAccessoriesList[index]
                          .nameAccessoriesController,
                      quantityController:
                          panelDataAccessoriesList[index].quantityController,
                      measurementController: panelDataAccessoriesList[index]
                          .measurementsController,
                      labelTextMaterial: "фурнитура *",
                      labelTextQuantity: "Кол-во на единицу *",
                      isButtonEnabled: true,
                      onPressedDeleteButton: () {
                        setState(() {
                          accessoriesWidgets.removeAt(index);
                          panelDataAccessoriesList.removeAt(index);
                        });
                      },
                    );
                  }),
                  // Создание новой панели фурнитуры
                  AddButton(
                    buttonTitle: "+ фурнитура",
                    onPressed: () {
                      setState(() {
                        final UniqueKey newPanelKey = UniqueKey();
                        TextEditingController nameAccessoriesController =
                            TextEditingController();
                        TextEditingController quantityController =
                            TextEditingController();
                        TextEditingController measurementController =
                            TextEditingController();

                        PanelDataAccessories newPanelData =
                            PanelDataAccessories(
                          nameAccessoriesController: nameAccessoriesController,
                          quantityController: quantityController,
                          measurementsController: measurementController,
                        );

                        panelDataAccessoriesList.add(newPanelData);
                        accessoriesWidgets.add(
                          CreateMaterialPanel(
                            key: newPanelKey,
                            materialNameController: nameAccessoriesController,
                            quantityController: quantityController,
                            measurementController: measurementController,
                            isButtonEnabled: true,
                            labelTextMaterial: "+ Материал",
                            labelTextQuantity: "Кол-во на ед. прод.",
                          ),
                        );
                      });
                    },
                  ),

                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                        backgroundColor: AppColors.enableButtonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: sendDataToServer,
                      child: const Text(
                        "Сохранить",
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void sendDataToServer() async {
    // Получаем данные из полей артикула
    String articleNumber = articleNumberController.text;
    String articleDescription = articleDescriptionController.text;

    try {
      // Отправляем данные артикула на сервер
      int articleId = await createMaterial.createArticle(
        nameArticle: articleNumber,
        descriptionArticle: articleDescription,
      );

      // Включаем данные из исходных панелей в список перед отправкой на сервер
      panelDataMaterialList.insert(
          0,
          PanelDataMaterial(
            nameMaterialController: nameMaterialController,
            quantityController: quantityMaterialController,
            measurementsController: measurementsMaterialController,
          ));

      panelDataAccessoriesList.insert(
          0,
          PanelDataAccessories(
            nameAccessoriesController: nameAccessoriesController,
            quantityController: quantityAccessoriesController,
            measurementsController: measurementsAccessoriesController,
          ));

      // Отправляем данные по материалам на сервер
      for (var panelData in panelDataMaterialList) {
        String nameMaterial = panelData.nameMaterialController.text;
        String quantity = panelData.quantityController.text;
        String measurementText = panelData.measurementsController.text;

        if (nameMaterial.isNotEmpty &&
            quantity.isNotEmpty &&
            measurementText.isNotEmpty) {
          int? measurement = int.tryParse(measurementText);
          if (measurement != null) {
            int materialId = await createMaterial.createMaterial(
              nameMaterial: nameMaterial,
              itemType: 'material',
              measurement: measurement,
            );

            await createMaterial.createArticleItem(
              int.parse(quantity),
              articleId,
              materialId,
            );
          }
        }

        // Очищаем поля
        nameMaterialController.clear();
        quantityMaterialController.clear();
        measurementsMaterialController.clear();
      }

      // Отправляем данные по фурнитуре на сервер
      for (var panelData in panelDataAccessoriesList) {
        String nameAccessories = panelData.nameAccessoriesController.text;
        String quantity = panelData.quantityController.text;
        String measurementText = panelData.measurementsController.text;

        if (nameAccessories.isNotEmpty &&
            quantity.isNotEmpty &&
            measurementText.isNotEmpty) {
          int? measurement = int.tryParse(measurementText);
          if (measurement != null) {
            int accessoriesId = await createMaterial.createAccessories(
              nameMaterial: nameAccessories,
              itemType: 'accessories',
              measurement: measurement,
            );

            await createMaterial.createArticleItem(
              int.parse(quantity),
              articleId,
              accessoriesId,
            );
          }
        }
        // Очищаем поля
        nameAccessoriesController.clear();
        quantityAccessoriesController.clear();
        measurementsAccessoriesController.clear();
      }

      // Показываем SnackBar об успешной отправке
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Данные успешно отправлены на сервер'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (error) {
      // Обработка ошибок
      print('Error sending data to server: $error');
    }

    // Очищаем поля
    articleNumberController.clear();
    articleDescriptionController.clear();
  }
}