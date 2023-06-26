import 'dart:async';
import 'package:flutter/cupertino.dart';
// import 'package:objectbox/objectbox.dart';
import 'package:weather_app/models/http_model.dart';
import '../db/city.dart';
import '../objectBox.g.dart';

class DataBaseModel extends ChangeNotifier {

  final Store _store;
  String? searchString;
  Condition<CityEntity>? conds;
  List<CityEntity> citiesListFromDB = [];
  List<dynamic> citiesData = [];

  DataBaseModel(this._store) {
    citiesFromDB();
    if (citiesListFromDB.isNotEmpty){
      getCitiesData();
    }
  }

  List<CityEntity> citiesFromDB() {
    if (searchString != null) {
      conds = CityEntity_.name
      .contains(searchString!.toLowerCase(), caseSensitive: false);
    }

    citiesListFromDB = _store
        .box<CityEntity>()
        .query(conds)
        .order(CityEntity_.name, flags: Order.descending)
        .build()
        .find();
    return citiesListFromDB;
  }

  search(String search) {
    searchString = search;
    notifyListeners();
  }

  void dbAddCity(name, state, country, lat, lon, id) {
    final box = _store.box<CityEntity>();
    var city = CityEntity();
    city.name = name;
    city.state = state;
    city.country = country;
    city.lat = lat;
    city.lon = lon;
    city.id = id;
    box.put(city);
    notifyListeners();
  }

  void dbDelete(int id) {
    final box = _store.box<CityEntity>();
    box.remove(id);
    notifyListeners();
  }

  void addCity(List<dynamic> cities){
    for (var i in citiesListFromDB) {
      cities.removeWhere((element) => element['id'] == i.id);
  }}

  Future<List<dynamic>> getCitiesData() async {
    for (var i in citiesListFromDB){
      String url = "https://api.openweathermap.org/data/2.5/weather?"
          "lat=${i.lat}&"
          "lon=${i.lon}&"
      // "exclude=&"
          "appid=092668ba17076cf6c077dfedfa76949c"
          "&units=metric";
      Map<String, dynamic> resp = await RequestModel().doRequest(url);
      if (resp['cod'] == 200){
      citiesData.add(resp);}
    }
    notifyListeners();
    return citiesData;
  }}
