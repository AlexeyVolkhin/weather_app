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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Загружаю данные с сервера',
                    style: TextStyle(color: Colors.black45.withOpacity(0.7))),
                const CircularProgressIndicator(color: Colors.black45,)
              ],);
    }

    if (model.response['cod'] == 200){
      return GestureDetector(
        onTap: (){
          context.go('/fullInfo');
        },
        child: Wrap(
                direction: Axis.vertical,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 10,
                children: [
                  Text(model.response['name']),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset('assets/icons/${model.response['weather'][0]['icon']}.svg',
                        color: Colors.black45,
                        width: 40,
                      ),
                      Text(' ${model.response['weather'][0]['main']}'),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/mainIcons/humidity.png', color: Colors.black45,),
                      Text(' ${model.response['main']['humidity']}%'),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/mainIcons/pressure.png', color: Colors.black45,),
                      Text(' ${(model.response['main']['pressure'])} мм рт. ст.',),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/mainIcons/wind.png', color: Colors.black45,),
                      Text(' ${(model.response['wind']['speed'])} м/с',),
                    ],
                  ),
                ],),
      );}

    else {
      return Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          const Text('Упс, произошла ошибка!   ',),
          TextButton(
              onPressed: () {
                model.getWeatherData();
              },
              icon: const Icon(Icons.refresh_outlined)),
          TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.black.withOpacity(0.5)),
              onPressed: () {
                context.pushNamed('base', pathParameters: {'response': jsonEncode(model.response)});
              },
              child: const Text('Подробнее')),
        ],);
      }

  }}
