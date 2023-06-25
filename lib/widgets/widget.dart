import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../models/http_model.dart';


class WidgetPage extends StatelessWidget {
  const WidgetPage({super.key});

  @override
  Widget build(BuildContext context) {

    final model = context.watch<RequestModel>();

    if (model.isLoading) {
      return Row(
              children: const [
                Expanded(child:  Text('Загружаю данные с сервера',)),
                CircularProgressIndicator()
              ],);
    }

    if (model.response['cod'] == 200){
      return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(model.response['name']),
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/${model.response['weather'][0]['icon']}.svg'),
                    Text(model.response['weather'][0]['main'],),
                  ],
                ),
                Row(
                  children: [
                    Image.asset('assets/mainIcons/humidity.png'),
                    Text((model.response['main']['humidity']).toString()),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset('assets/mainIcons/pressure.png'),
                    Expanded(child: Text('${(model.response['main']['pressure']).toString()} мм рт. ст.',)),
                  ],
                ),
                Row(
                  children: [
                    Image.asset('assets/mainIcons/wind.png'),
                    Expanded(child: Text('${(model.response['wind']['speed']).toString()} м/с', )),
                  ],
                ),
              ],);}

    else {
      return Row(
        children: [
          const Expanded(child:  Text('Упс, произошла ошибка',)),
          TextButton(
              onPressed: () {
                model.getWeatherData();
              },
              child: const Text('Обновить')),
          TextButton(
              onPressed: () {
                context.pushNamed('base', pathParameters: {'response': jsonEncode(model.response)});
              },
              child: const Text('Подробнее')),
        ],);
      }

  }}
