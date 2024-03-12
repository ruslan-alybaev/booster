import 'package:dio/dio.dart';

class CreateMaterial {
  final Dio dio = Dio();

  Future<int> createArticle({
    required String nameArticle,
    String? descriptionArticle,
  }) async {
    try {
      Response response = await dio.post(
        'http://143.110.190.57:8002/api/article/',
        data: {
          "name": 'name',
          "number": nameArticle,
          "description": descriptionArticle,
        },
      );

      print('Response: ${response.statusCode}');
      print('Data: ${response.data}');

      return response.data['id'];
    } catch (error) {
      print('Error create craeteArticule : $error');
      throw error;
    }
  }

  Future<int> createMaterial({
    required String nameMaterial,
    required String itemType,
    required int measurement,
  }) async {
    try {
      Response response = await dio.post(
        'http://143.110.190.57:8002/api/item/',
        data: {
          "name": nameMaterial,
          "item_type": itemType,
          "measurement": measurement,
        },
      );

      print('Material created successfully. Data: ${response.data}');

      return response.data['id'];
    } catch (error) {
      print('Error created createMaterial : $error');
      throw error;
    }
  }

  Future<int> createAccessories({
    required String nameMaterial,
    required String itemType,
    required int measurement,
  }) async {
    try {
      Response response = await dio.post(
        'http://143.110.190.57:8002/api/item/',
        data: {
          "name": nameMaterial,
          "item_type": itemType,
          "measurement": measurement,
        },
      );

      print('Accessories created successfully. Data: ${response.data}');
      return response.data['id'];
    } catch (error) {
      print('Error created Accessories: $error');
      throw error;
    }
  }

  Future<void> createArticleItem(
    int quantity,
    int articleId,
    int itemId,
  ) async {
   
    try {
      Response response = await dio.post(
        'http://143.110.190.57:8002/api/article_item/',
        data: {
          "quantity": quantity,
          "article": articleId,
          "item": itemId,
        },
      );
      print('Response: ${response.statusCode}');
      print('Data created successfully  createArticleItem: ${response.data}');
    } catch (error) {
      print('Error created createArticleItem : $error');
    }
  }
}
