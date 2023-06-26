import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class InfoPage extends StatelessWidget {
  final String response;
  const InfoPage({super.key, required this.response});

  @override
  Widget build(BuildContext context) {
    Map jsonResponse = jsonDecode(response);

    return Scaffold(
      floatingActionButton: TextButton(
          style: TextButton.styleFrom(foregroundColor: Colors.black.withOpacity(0.5)),
          onPressed: (){
            context.pop();
          },
          child: const Text('Назад')),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      body: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.cover,
                  ))),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: Text(jsonResponse['message']))
          ]),
    );
  }}