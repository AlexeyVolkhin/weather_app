import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/db/db.dart';
import 'package:weather_app/models/db_model.dart';
import 'package:weather_app/pages/cities_list_page.dart';
import 'package:weather_app/pages/info_page.dart';
import 'package:weather_app/pages/cities_page.dart';
import 'package:weather_app/pages/home_page.dart';

import 'models/http_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!(await Permission.location.isGranted)) {
    await Permission.location.request();
  }

  final objectbox = await ObjectBox.create();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => RequestModel(),
    ),
    ChangeNotifierProvider(
      create: (_) => DataBaseModel(objectbox.store),
    ),

  ], child:  MyApp()));
}

class MyApp extends StatelessWidget {

  final _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),

        routes: [
          GoRoute(
              path: "cities",
              builder: (context, state) => const CitiesPage()),
          GoRoute(
              path: "citiesManager",
              builder: (context, state) => const CitiesManager()),
          GoRoute(
              path: "base:response",
              name: "base",
              builder: (context, state) {
                  return InfoPage(
                    response: state.pathParameters['response']!
                  );
                }
              )
        ],
      ),
    ],
  );

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RequestModel>(builder: (context, value, child) {
      // print("${value.response['weather'][0]['main']}2313123213213");
      // print("${value.response['weather'].runtimeType}");
      if (value.response.isEmpty) {
        return const MaterialApp(
          home: HomePage(),
        );
      }

      return MaterialApp.router(
        routerConfig: _router,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
      );
    });
  }
}

