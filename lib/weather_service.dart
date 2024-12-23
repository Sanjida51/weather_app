import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = '961df2eabf8e763ce5b0d85bf1a2d462'; // Replace with your OpenWeatherMap API key
  final String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  final String forecastUrl = 'https://api.openweathermap.org/data/2.5/onecall'; // For 7-day forecast

  Future<Map<String, dynamic>> fetchWeather(String city) async {
    final url = '$baseUrl?q=$city&appid=$apiKey&units=metric';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }

  Future<Map<String, dynamic>> fetch7DayForecast(String city) async {
    // Get the coordinates of the city first
    final cityWeather = await fetchWeather(city);
    double lat = cityWeather['coord']['lat'];
    double lon = cityWeather['coord']['lon'];

    final url =
        '$forecastUrl?lat=$lat&lon=$lon&appid=$apiKey&units=metric';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch forecast data');
    }
  }
}
