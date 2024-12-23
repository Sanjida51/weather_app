import 'package:flutter/material.dart';

class AlertButton extends StatelessWidget {
  final double temperature;

  const AlertButton({required this.temperature});

  @override
  Widget build(BuildContext context) {
    // Determine the button color and alert message based on temperature
    String alertMessage;
    Color buttonColor;

    if (temperature <= 10) {
      alertMessage = 'Cold Wave Alert: Current Temperature: $temperature°C';
      buttonColor = Colors.blue; // Color for Cold Wave
    } else if (temperature >= 40) {
      alertMessage = 'Heat Wave Alert: Current Temperature: $temperature°C';
      buttonColor = Colors.red; // Color for Heat Wave
    } else {
      alertMessage = 'Normal Temperature: Current Temperature: $temperature°C';
      buttonColor = Colors.green; // Color for Normal Temperature
    }

    return ElevatedButton(
      onPressed: () {
        // Show the temperature alert dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Temperature Alert'),
            content: Text(alertMessage),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      ),
      child: Text(
        'ALERT',
        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
