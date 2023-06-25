import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CitiesPage extends StatelessWidget {
  const CitiesPage ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),

        body: Stack(
        alignment: AlignmentDirectional.center,
        // fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
            image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
                ))),
        Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              IconButton(
                  onPressed: () {
                    context.go('/citiesManager');
                  },
                  icon: const Icon(Icons.add))
            ],)),
      ],
    ));
  }

}