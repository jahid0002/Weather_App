import 'dart:convert';

import 'package:weather/const/url_const.dart';
import 'package:weather/model/weather_model.dart';
import 'package:http/http.dart';

class WeatherData {
  Future<WeatherModel> getWeather(String searchText) async {
    String url = '$baseUrl&q=$searchText&days=7';

    try {
      Response response = await get(Uri.parse(url));

      if (response.statusCode == 200) {
       Map<String, dynamic> json = jsonDecode(response.body);
        WeatherModel weatherModel = WeatherModel.fromJson(json);
        return weatherModel;
      } else {
        throw ('No data found');
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
