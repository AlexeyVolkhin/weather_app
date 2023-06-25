import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/widgets/widget.dart';

import '../models/http_model.dart';

class HomePage extends StatelessWidget {
  final Widget? widget;
  const HomePage({super.key, this.widget});

  @override
  Widget build(BuildContext context) {
    // final model = context.watch<RequestModel>();
    final theme = Theme.of(context);
    final titleTextStyle = theme.textTheme.headline1;
    final TextStyle style =  TextStyle(
      foreground: Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4
        ..color = Colors.black,
      decoration: TextDecoration.none
    );
    // print(model.response);

    final page = Scaffold(
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
                          context.go('/cities');
                        },
                        icon: const Icon(Icons.add))
                  ],)),
              const WidgetPage(),

              ]),
    );

  return page;
}}