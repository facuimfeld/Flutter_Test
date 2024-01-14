import 'dart:convert';

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
    if (resp.statusCode == 200) {
      Map<String, dynamic> result = json.decode(utf8.decode(resp.bodyBytes));
      List<Map<String, dynamic>> weatherByHour =
          result["forecast"]["forecastday"][0]["hour"];
    }
    return probabilityRain;
  }
}
