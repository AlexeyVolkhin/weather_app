import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/widgets/widget.dart';

import '../models/http_model.dart';


class FullInfoPage extends StatelessWidget {
  const FullInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<RequestModel>();

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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
              child: Wrap(
                spacing: 10,
                direction: Axis.vertical,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text('Местоположение ${model.response['name']}'),
                  Text('Сейчас ${model.response['weather'][0]['main']} ${model.response['weather'][0]['description']}'),
                  Text('Температура ${model.response['main']['temp'].toString()} °C'),
                  Text('Ощущается как ${model.response['main']['feels_like'].toString()} °C'),
                  Text('Минимальная температура ${model.response['main']['temp_min'].toString()} °C'),
                  Text('Максимальная температура  ${model.response['main']['temp_max'].toString()} °C'),
                  Text('Атмосферное давление ${model.response['main']['pressure'].toString()} мм рт. ст.'),
                  Text('Влажность воздуха ${model.response['main']['humidity'].toString()}%'),
                  Text('Видимость ${model.response['visibility'].toString()} км'),
                  Text('Скорость ветра ${model.response['wind']['speed'].toString()} м/с'),
                  Text('Направление ветра ${model.response['wind']['deg'].toString()} °'),
                  Text('Облачность ${model.response['clouds']['all'].toString()}%'),
              ],),
            )
          ]),
    );
  }}