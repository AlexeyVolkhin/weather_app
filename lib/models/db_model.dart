
import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:objectbox/objectbox.dart';

import '../db/map.dart';

class DataBaseModel extends ChangeNotifier {

  final Store _store;
  List<dynamic> pointList = [];
  String? searchString;



  DataBaseModel(this._store) {
    getCitiesList();
  }

  search(String search) {
    searchString = search;
    notifyListeners();
  }

   Future<List<dynamic>> getCitiesList() async {
    var response = await rootBundle.loadString('assets/cities/city_list.json');
    pointList = await jsonDecode(response);
    print(pointList);
    print(pointList.runtimeType);
    print(pointList[0]);
    notifyListeners();
    return pointList;
  }

  Future<Map<String, dynamic>> doRequest(url) async {
    final uri = Uri.parse(url);
    final req = http.Request("POST", uri);
    req.headers["Content-Type"] = "application/json";
    var client = http.Client();
    final http.StreamedResponse resp;
    final String body;

    try {
      resp = await client.send(req).timeout(const Duration(seconds: 15));
      body = await resp.stream.bytesToString();

    } finally {
      client.close();
    }

    return jsonDecode(body);

  }}