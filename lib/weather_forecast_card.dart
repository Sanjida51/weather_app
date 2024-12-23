import 'package:flutter/material.dart';

class WeatherForecastCard extends StatelessWidget {
  final Map<String, dynamic> forecastData;

  const WeatherForecastCard({required this.forecastData});

  @override
  Widget build(BuildContext context) {
    List forecastList = forecastData['daily']; // Assuming the forecast data has a 'daily' list

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '7-Day Forecast',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueAccent),
            ),
            SizedBox(height: 10),
            Column(
              children: List.generate(forecastList.length, (index) {
                var dayData = forecastList[index];
                String day = _getDayOfWeek(index);
                double temp = dayData['temp']['day'];
                String description = dayData['weather'][0]['description'];
                String iconCode = dayData['weather'][0]['icon'];

                // Adding weather icon for each day
                IconData tempIcon = _getTemperatureIcon(temp);

                return ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                  leading: Image.network('https://openweathermap.org/img/wn/$iconCode@2x.png'),
                  title: Row(
                    children: [
                      Text(day, style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(width: 8),
                      Icon(tempIcon, color: Colors.orangeAccent), // Add temperature-related icon
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      Icon(Icons.cloud, color: Colors.grey), // Cloud icon
                      SizedBox(width: 8),
                      Text(description),
                    ],
                  ),
                  trailing: Text(
                    '${temp.toStringAsFixed(1)}°C',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to get day of the week
  String _getDayOfWeek(int index) {
    DateTime today = DateTime.now();
    DateTime forecastDate = today.add(Duration(days: index));
    switch (forecastDate.weekday) {
      case 1:
        return 'Sunday';
      case 2:
        return 'Monday';
      case 3:
        return 'Tuesday';
      case 4:
        return 'Wednesday';
      case 5:
        return 'Thursday';
      case 6:
        return 'Friday';
      case 7:
        return 'Saturday';
      default:
        return 'Unknown';
    }
  }

  // Function to get temperature icon based on temperature
  IconData _getTemperatureIcon(double temp) {
    if (temp < 10) {
      return Icons.ac_unit; // Snowflake icon for cold temperatures
    } else if (temp < 20) {
      return Icons.wb_sunny; // Sun icon for moderate temperatures
    } else {
      return Icons.wb_sunny_outlined; // Sun with outline for hot temperatures
    }
  }
}
