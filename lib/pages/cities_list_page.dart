import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/db/city.dart';
import 'package:weather_app/models/cities_list_model.dart';
import 'package:weather_app/models/db_model.dart';

import '../models/db_model.dart';
import '../widgets/search_bar.dart';

class CitiesManager extends StatefulWidget {
  const CitiesManager({super.key});

  @override
  State<CitiesManager> createState() => _CitiesManagerState();
}

class _CitiesManagerState extends State<CitiesManager> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState(){
    super.initState();
    var model = Provider.of<DataBaseModel>(context, listen: false);

  }

  List<int> selectedItems = [];

  @override
  Widget build(BuildContext context) {


    final model = context.watch<CitiesListModel>();
    final dataBaseModel = context.watch<DataBaseModel>();

    List<dynamic> citiesList = model.citiesListFunc();
    for (var i in dataBaseModel.citiesListFromDB) {
      citiesList.removeWhere((element) => element['id'] == i.id);
    }

    return Scaffold(
        key: _scaffoldKey,
        floatingActionButton: TextButton(
            onPressed: (){
              context.pop();
            },
            child: const Text('Назад')),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 30),
                child: SafeArea(
                  child: Column(children: [
                    SearchField(model.searchString, (val) => model.search(val)),
                    Expanded(
                      child: MasonryGridView.builder(
                        gridDelegate:
                        const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                      ),
                        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                        cacheExtent: 1.0,
                        itemCount: citiesList.length,
                        addAutomaticKeepAlives: false,
                        itemBuilder: (context, index) {

                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 3),
                            child: ListTile(
                              trailing: IconButton(
                                  onPressed: (){
                                    dataBaseModel.dbAddCity(
                                        citiesList[index]['name'],
                                        citiesList[index]['state'],
                                        citiesList[index]['country'],
                                        citiesList[index]['coord']['lat'],
                                        citiesList[index]['coord']['lon'],
                                        citiesList[index]['id'],
                                    );
                                    citiesList.removeWhere((element) => element['id'] == citiesList[index]['id'],
                                    );

                                  },
                                  icon: const Icon(Icons.add)),
                              title: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(citiesList[index]['name'],
                                      style: const TextStyle(fontWeight: FontWeight.w700)),
                                  Text(citiesList[index]['state'],
                                      style: const TextStyle(fontWeight: FontWeight.w700)),
                                  Text(citiesList[index]['country'],
                                      style: const TextStyle(color: Colors.black)),
                                  Text(citiesList[index]['id'].toString(),
                                      style: const TextStyle(color: Colors.black)),
                                  Text(
                                      style: const TextStyle(wordSpacing: 5),
                                      '${citiesList[index]['coord']['lat']}  ${citiesList[index]['coord']['lon']}'),
                                ],
                              ),
                            ),
                          );
                      }),
                ),
            ]),
          ),
              ),
        ]));
  }
}
