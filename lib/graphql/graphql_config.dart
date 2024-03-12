import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConfig {
  static HttpLink httpLink = HttpLink(
    'http://143.110.190.57:8002/graphql/',
  );

  GraphQLClient client() => GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(),
      );
}
