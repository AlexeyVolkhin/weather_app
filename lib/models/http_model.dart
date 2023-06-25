
import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class RequestModel extends ChangeNotifier {

  Map<String, dynamic> response = {};
  bool isLoading = false;
  String url = '';

  RequestModel() {
    getWeatherData();
  }


  Future<void> getWeatherData() async {
    isLoading = true;
    try {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    url = "https://api.openweathermap.org/data/2.5/weather?"
        "lat=${position.latitude}&"
        "lon=${position.longitude}&"
        // "exclude=&"
        "appid=092668ba17076cf6c077dfedfa76949c"
        "&units=metric";
    } on Exception {
      throw Exception("Не получилось обнаружить геолокацию, проверьте настройки и доступ к интернету");
    }

    if (url.isNotEmpty) {
    response = await doRequest(url);
    isLoading = false;
    notifyListeners();

  }}

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
  }


}