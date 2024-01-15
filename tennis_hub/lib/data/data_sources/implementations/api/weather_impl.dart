import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:tennis_hub/data/data_sources/interfaces/weather.dart';
import 'package:http/http.dart' as http;

class Weather implements WeatherInt {
  //Weather APIKey
  String apiKey = 'ff9f1d69ea0843b18f8182710241201';

  @override
  Future<double> getProbabilityRain(DateTime time) async {
    double probabilityRain = 0.0;
    String date = '${time.year}-${time.month}-${time.day}';
    String hour = '${time.hour}:${time.minute}';

    String urlApi =
        'https://api.weatherapi.com/v1/future.json?key=ff9f1d69ea0843b18f8182710241201&q=Resistencia&dt=$date';
    var resp = await http.get(Uri.parse(urlApi), headers: {
      'Content-Type': 'application/json',
    });
    //print('resp1' + resp.body.toString());
    //print('date ' + date);
    if (resp.statusCode == 200) {
      Map<String, dynamic> result = json.decode(utf8.decode(resp.bodyBytes));
      List<dynamic> hours = result["forecast"]["forecastday"][0]["hour"];

      for (int i = 0; i <= hours.length - 1; i++) {
        probabilityRain = probabilityRain +
            double.parse(hours[i]["chance_of_rain"].toString());
      }

      probabilityRain = probabilityRain / hours.length;
      // print(result["forecast"]["forecastday"][0]["hour"].toString());
    }
    return probabilityRain;
  }
}
