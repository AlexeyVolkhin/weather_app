
import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class CitiesListModel extends ChangeNotifier {

  List<dynamic> citiesList = [];
  String? searchString;


  CitiesListModel() {
    getCitiesList();
  }

  search(String search) {
    searchString = search;
    notifyListeners();
  }

  Future<List<dynamic>> getCitiesList() async {
    var response = await rootBundle.loadString('assets/cities/city_list.json');
    citiesList = await jsonDecode(response);
    notifyListeners();
    return citiesList;
  }

  List<dynamic> citiesListFunc(){
    if (searchString != null) {
      return citiesList.where((element) =>
          element['name'].contains(searchString)).toList();
    }

    return citiesList;

  }}