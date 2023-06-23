import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/post.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<RequestModel>();
    print(model.response);

    final page = Stack(
          // alignment: AlignmentDirectional.center,
            // fit: StackFit.expand,
          children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.cover,
                  ))),

            ]);
    if (model.isLoading) {
      return Stack(
          alignment: AlignmentDirectional.center,
          children: [
          page,
          Row(
            children: const [
              Expanded(child: Text('Загружаю данные с сервера')),
              CircularProgressIndicator()
              ],)
          ]);
    }

    if (model.response.isNotEmpty){

      return Stack(
        alignment: AlignmentDirectional.center,
        children: [
          page,
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            Text(model.response['name']),
            Row(
              children: [
                Image.asset('assets/images/background.png'),
                Text(model.response['weather'][0]['main']),
              ],
            ),
            Text(model.response['weather'][0]['main']),
            Text(model.response['weather'][0]['main']),
            Text(model.response['weather'][0]['main']),
            Text(model.response['weather'][0]['main']),
            Text(model.response['weather'][0]['main']),
          ],)

      ]);
    }

  return page;
}}