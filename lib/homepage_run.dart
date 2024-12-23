import 'package:flutter/material.dart';
import 'weather_service.dart';
import 'weather_card.dart';
import 'weather_forecast_card.dart'; // A new card for daily forecast

class HomePageRun extends StatefulWidget {
  @override
  _HomePageRunState createState() => _HomePageRunState();
}

class _HomePageRunState extends State<HomePageRun> {
  final TextEditingController _controller = TextEditingController();
  Map<String, dynamic>? _weatherData;
  Map<String, dynamic>? _forecastData;
  bool _isLoading = false;

  // Fetch weather and forecast data
  void _getWeather() async {
    setState(() {
      _isLoading = true;
    });
    try {
      // Fetch current weather
      final weather = await WeatherService().fetchWeather(_controller.text);
      setState(() {
        _weatherData = weather;
      });

      // Fetch 7-day forecast data
      final forecast = await WeatherService().fetch7DayForecast(_controller.text);
      setState(() {
        _forecastData = forecast;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching weather data')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.search), // Replaced with standard Flutter Icons
            onPressed: _getWeather,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue, Colors.purple],
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input field for city name
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter City',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white.withOpacity(0.7),
                suffixIcon: Icon(Icons.search), // Replaced with standard Flutter Icons
              ),
            ),
            SizedBox(height: 10),

            // Button to fetch weather data
            ElevatedButton.icon(
              onPressed: _getWeather,
              icon: Icon(Icons.cloud), // Replaced with standard Flutter Icons
              label: Text('Get Weather'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            SizedBox(height: 20),

            // Loading indicator
            if (_isLoading)
              CircularProgressIndicator()
            else if (_weatherData != null)
              WeatherCard(weatherData: _weatherData!),
            SizedBox(height: 20),

            // Show forecast if available
            if (_forecastData != null)
              WeatherForecastCard(forecastData: _forecastData!),
          ],
        ),
      ),
    );
  }
}
