import 'dart:convert';

import 'package:demo37/screens/home/modal/home_modal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiCall {
  Future<HomeModal?> getData(String name) async {
    print("========== $name");
    String? link =
        "https://api.openweathermap.org/data/2.5/weather?q=$name&appid=1177b1e3edcc54bc767e02d9b9806249";
    var response = await http.get(
      Uri.parse(link),
    );

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return HomeModal.fromJson(json);
    } else {
      return null;
    }
  }
}
