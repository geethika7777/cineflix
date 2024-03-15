// Import necessary packages and files
import 'package:flutter/material.dart';  // Flutter Material package for UI
import 'package:shared_preferences/shared_preferences.dart';  // Package for storing preferences
import 'package:cineflix/screens/signuppage.dart';  // Importing SignUpPage for navigating to sign up page
import 'package:cineflix/screens/home_screen.dart';  // Importing HomeScreen for navigating to home screen

// Class for the login screen of the application
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);  // Constructor for LoginPage

  @override
  _LoginPageState createState() => _LoginPageState();  // Create state for LoginPage
}

// State class for LoginPage widget
class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();  // Controller for email text field
  TextEditingController _passwordController = TextEditingController();  // Controller for password text field

  @override
  Widget build(BuildContext context) {  // Build method to define the UI of the widget
    return Scaffold(  // Scaffold widget to create a basic layout structure
      appBar: AppBar(  // AppBar widget for the top app bar
        title: Text("Login"),  // Title of the app bar
        centerTitle: true,  // Center align the title
      ),
      body: Padding(  // Padding around content
        padding: const EdgeInsets.all(16.0),  // Padding of 16.0
        child: Column(  // Column for arranging content vertically
          mainAxisAlignment: MainAxisAlignment.center,  // Align content vertically in the center
          children: [
            TextField(  // TextField widget for email input
              controller: _emailController,  // Controller for email input
              decoration: InputDecoration(labelText: 'Email'),  // Label text for email input
            ),
            SizedBox(height: 16.0),  // SizedBox for vertical spacing
            TextField(  // TextField widget for password input
              controller: _passwordController,  // Controller for password input
              obscureText: true,  // Hide password characters
              decoration: InputDecoration(labelText: 'Password'),  // Label text for password input
            ),
            SizedBox(height: 32.0),  // SizedBox for vertical spacing
            ElevatedButton(  // ElevatedButton widget for login
              onPressed: () async {  // Callback function when login button is pressed
                final prefs = await SharedPreferences.getInstance();  // Get SharedPreferences instance
                
                if (_emailController.text == 'test@example.com' &&  // Check if email and password match
                    _passwordController.text == 'password123') {
                  await prefs.setBool('isLoggedIn', true);  // Set isLoggedIn to true
                  Navigator.pushReplacement(context,  // Navigate to home screen
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(  // Show snackbar for invalid credentials
                      SnackBar(content: Text('Invalid credentials')));
                }
              },
              child: Text('Login'),  // Text for login button
            ),
            TextButton(  // TextButton for navigating to sign up page
              onPressed: () {  // Callback function when sign up button is pressed
                Navigator.push(context,  // Navigate to sign up page
                    MaterialPageRoute(builder: (context) => SignupPage()));
              },
              child: Text('Don\'t have an account? Sign up'),  // Text for sign up button
            ),
          ],
        ),
      ),
    );
  }
}
