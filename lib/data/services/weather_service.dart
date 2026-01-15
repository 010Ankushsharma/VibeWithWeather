
import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:vibewithweather/data/models/forecast_model.dart';
import 'package:vibewithweather/data/models/weather_model.dart';
import '../../core/constants/api_constants.dart';
import 'package:geolocator/geolocator.dart';


class WeatherService {

  // get weather from api
  Future<WeatherModel> getWeather(String cityName) async {
    final response = await http.get(
      Uri.parse(
        '${ApiConstants.baseUrl}?q=$cityName&appid=${ApiConstants
            .apiKey}&units=metric',
      ),
    );
    if (response.statusCode == 200) {
      return WeatherModel.formJson(jsonDecode(response.body));
    }
    else {
      throw Exception('Failed to load weather');
    }
  }

  //Get current city using GPS
  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude);

    return placemarks.first.locality ?? ' ';
  }

  // get forecast
  Future<List<ForecastModel>> getForecast(String cityName) async {
    final response = await http.get(
      Uri.parse(
        '${ApiConstants.forecastUrl}?q=$cityName&appid=${ApiConstants
            .apiKey}&units=metric',
      ),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List list = data['list'];

      return list
          .map((e) => ForecastModel.formJson(e))
          .toList();
    } else {
      throw Exception('Failed to load forecast');
    }
  }
}
