import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  final Map<String, dynamic> weatherData;

  const WeatherCard({required this.weatherData});

  @override
  Widget build(BuildContext context) {
    String weatherCondition = weatherData['weather'][0]['main'].toLowerCase();
    String iconUrl = 'https://openweathermap.org/img/wn/${weatherData['weather'][0]['icon']}@2x.png';

    // Get additional weather data
    double temperature = weatherData['main']['temp'];
    double feelsLike = weatherData['main']['feels_like'];
    int humidity = weatherData['main']['humidity'];
    double windSpeed = weatherData['wind']['speed'];
    int pressure = weatherData['main']['pressure'];
    String cityName = weatherData['name'];

    // Color based on weather condition
    Color backgroundColor;
    if (weatherCondition == 'clear') {
      backgroundColor = Colors.blue.shade100; // Clear skies
    } else if (weatherCondition == 'rain') {
      backgroundColor = Colors.blueGrey.shade100; // Rainy
    } else if (weatherCondition == 'clouds') {
      backgroundColor = Colors.grey.shade300; // Cloudy
    } else {
      backgroundColor = Colors.white; // Default
    }

    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 10),
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.network(
                  iconUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ), // Display weather icon
                SizedBox(width: 10),
                Text(
                  'City: $cityName',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'Temperature: $temperature°C',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Feels Like: $feelsLike°C',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Weather: ${weatherCondition.capitalize()}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Humidity: $humidity%',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Wind Speed: $windSpeed m/s',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Pressure: $pressure hPa',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

// Extension to capitalize the first letter of the string
extension StringCapitalization on String {
  String capitalize() {
    if (this.isEmpty) return this;
    return '${this[0].toUpperCase()}${this.substring(1)}';
  }
}
