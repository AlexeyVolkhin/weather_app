import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/widgets/widget_home_page.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: TextButton(
          style: TextButton.styleFrom(foregroundColor: Colors.black.withOpacity(0.5)),
          onPressed: (){
            context.go('/cities');
            },
          child: const Text('Список городов')),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,

      body: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/background.png'),
                      fit: BoxFit.cover,
                    ))),
              const WidgetPage(),
              ]),
    );
}}