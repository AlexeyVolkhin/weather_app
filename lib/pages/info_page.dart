import 'dart:convert';
import 'package:flutter/material.dart';


class InfoPage extends StatelessWidget {
  final String response;
  const InfoPage({super.key, required this.response});

  @override
  Widget build(BuildContext context) {
    Map jsonResponse = jsonDecode(response);

    return Scaffold(
      body: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.cover,
                  ))),
            Text(jsonResponse['message'])
          ]),
    );
  }}