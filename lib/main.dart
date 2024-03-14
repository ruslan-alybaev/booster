import 'package:booster/data/measurement_cubit.dart';
import 'package:booster/graphql/graphql_config.dart';
import 'package:booster/presentation/screens/create_article_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              MeasurementCubit(client: GraphQLConfig().client()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Ubuntu",
        ),
        home: const CreateArticleScreen(),
      ),
    );
  }
}
