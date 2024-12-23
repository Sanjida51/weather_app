import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'submit.dart'; // Importing the SubmitPage

class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController weatherController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Function to submit data to the PHP script
  Future<void> submitData(BuildContext context) async {
    final url = Uri.parse("http://localhost/weather_app/login.php");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "username": usernameController.text,
        "email": emailController.text,
        "contact": contactController.text,
        "address": addressController.text,
        "weather": weatherController.text,
        "password": passwordController.text,
      }),
    );

    final responseData = json.decode(response.body);

    if (responseData["status"] == "success") {
      // On success, navigate to SubmitPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SubmitPage()),
      );
    } else {
      print("Error: ${responseData["message"]}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.yellow, Colors.lightBlue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Username field
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                SizedBox(height: 16),
                // Email field
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                SizedBox(height: 16),
                // Contact number field
                TextField(
                  controller: contactController,
                  decoration: InputDecoration(
                    labelText: 'Contact Number',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.phone),
                  ),
                ),
                SizedBox(height: 16),
                // Address field
                TextField(
                  controller: addressController,
                  decoration: InputDecoration(
                    labelText: 'Address',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.home),
                  ),
                ),
                SizedBox(height: 16),
                // Weather/Climate condition field
                TextField(
                  controller: weatherController,
                  decoration: InputDecoration(
                    labelText: 'Weather/Climate Condition',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.wb_sunny),
                  ),
                ),
                SizedBox(height: 16),
                // Password field
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
                SizedBox(height: 32),
                // Submit button
                Center(
                  child: ElevatedButton(
                    onPressed: () => submitData(context),  // Calling submitData
                    child: Text('Submit'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
