import 'package:flutter/material.dart';
import 'homepage_run.dart'; // Import the page we want to navigate to
import 'weather_service.dart'; // Import weather service for fetching data
import 'login.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<TextStyle> _textAnimation;
  late Animation<Offset> _textMoveAnimation;
  late Animation<Offset> _buttonSlideAnimation;
  double? temperature; // Store the temperature
  String city = "Chittagong"; // You can change to any city

  final WeatherService weatherService = WeatherService();

  @override
  void initState() {
    super.initState();

    // Create AnimationController with duration of 1 second
    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    // Define animated text style
    _textAnimation = TextStyleTween(
      begin: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      end: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    // Define animation for moving text
    _textMoveAnimation = Tween<Offset>(
      begin: Offset(0, 1), // Start off-screen
      end: Offset(0, 0), // End in its original position
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    // Slide animation for the button
    _buttonSlideAnimation = Tween<Offset>(
      begin: Offset(0, 1), // Start off-screen at the bottom
      end: Offset(0, 0), // End at its original position
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    // Start animation when the page is loaded
    _animationController.forward();

    fetchWeatherData(); // Fetch weather data on page load
  }

  Future<void> fetchWeatherData() async {
    try {
      var weatherData = await weatherService.fetchWeather(city);
      setState(() {
        temperature = weatherData['main']['temp'].toDouble();
      });
    } catch (e) {
      print('Error fetching weather data: $e');
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Determine button color based on temperature
    Color alertButtonColor = (temperature != null && temperature! > 50) ? Colors.red : Colors.green;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.login, color: Colors.white), // Login icon
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
        ),

        backgroundColor: Colors.blueAccent,
        title: Stack(
          children: [
            Center(
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Text(
                    'Weather App',
                    style: _textAnimation.value,
                  );
                },
              ),
            ),
          ],
        ),
      ),


      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Display Image with fade-in animation
                    AnimatedOpacity(
                      opacity: 1.0,
                      duration: Duration(seconds: 1),
                      //child: Image.asset('assets/images/weather1.jpg'), // Make sure this image exists
                    ),
                    SizedBox(height: 250, // Adjust height as per your requirement
                      width: 300, // Adjust width as per your requirement
                      child: Image.asset('assets/images/weather1.jpg'),),

                    // Animated description text
                    SlideTransition(
                      position: _textMoveAnimation,
                      child: Text(
                        'Stay updated with the latest weather forecasts and get informed about the climate.',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 30),

                    // Display current temperature
                    if (temperature != null)
                      Text(
                        'Current Temperature: ${temperature!.toStringAsFixed(2)}°C',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                  ],
                ),
              ),
            ),

            // Slide-in Alert Button
            Align(
              alignment: Alignment.bottomCenter,
              child: SlideTransition(
                position: _buttonSlideAnimation,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePageRun()), // Navigate to HomePageRun
                      );
                    },
                    child: Text('Get Started'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: alertButtonColor, // Dynamic button color
                      foregroundColor: Colors.white, // Text color
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      shadowColor: Colors.black, // Button shadow
                      elevation: 10, // Button elevation (shadow effect)
                      minimumSize: Size(120, 40), // Smaller button size
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // Rounded button corners
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
