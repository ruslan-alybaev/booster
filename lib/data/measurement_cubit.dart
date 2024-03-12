import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MeasurementCubit extends Cubit<List<Map<String, dynamic>>> {
  final GraphQLClient client;

  MeasurementCubit({required this.client}) : super([]) {
    fetchMeasurementNames();
  }

  void fetchMeasurementNames() async {
    try {
      QueryResult result = await client.query(
        QueryOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql('''
          query MyQuery {
            measurements {
              edges {
                node {
                  name
                  id
                }
              }
            }
          }
        '''),
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception);
      }

      final measurementsList = result.data?['measurements']['edges'] ?? [];
      List<Map<String, dynamic>> measurements =
          (measurementsList as List<dynamic>)
              .map<Map<String, dynamic>>((edge) => {
                    'id': edge['node']['id'],
                    'name': edge['node']['name'],
                  })
              .toList();

      emit(measurements);
    } catch (error) {
      print('Ошибка при получении имен измерений: $error');
    }
  }
}
