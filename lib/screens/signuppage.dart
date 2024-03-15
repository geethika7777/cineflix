import 'package:flutter/material.dart';  // Importing Flutter Material package for UI
import 'package:cineflix/screens/login_page.dart';  // Importing LoginPage for navigation

// Class for the signup page of the application
class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);  // Constructor for SignupPage

  @override
  _SignupPageState createState() => _SignupPageState();  // Create state for SignupPage
}

// State class for SignupPage widget
class _SignupPageState extends State<SignupPage> {
  TextEditingController _emailController = TextEditingController();  // Controller for email input field
  TextEditingController _passwordController = TextEditingController();  // Controller for password input field

  @override
  Widget build(BuildContext context) {  // Build method to define the UI of the widget
    return Scaffold(  // Scaffold widget to create a basic layout structure
      appBar: AppBar(  // AppBar widget for the top app bar
        title: Image.asset(  // Image asset for the title
          'assets/CINEFLIX-removebg-preview.png',  // Image path
          fit: BoxFit.cover,  // Image fit property
          height: 180,  // Image height
          filterQuality: FilterQuality.high,  // Image filter quality
        ),
        centerTitle: true,  // Center the title
      ),
      body: Padding(  // Padding around the main content
        padding: const EdgeInsets.all(16.0),  // Padding of 16.0
        child: Column(  // Column for arranging content vertically
          mainAxisAlignment: MainAxisAlignment.center,  // Center content vertically
          children: [
            TextField(  // TextField widget for email input
              controller: _emailController,  // Controller for email input
              decoration: InputDecoration(labelText: 'Email'),  // Decoration for email input
            ),
            SizedBox(height: 16.0),  // SizedBox for adding spacing
            TextField(  // TextField widget for password input
              controller: _passwordController,  // Controller for password input
              obscureText: true,  // Hide the password text
              decoration: InputDecoration(labelText: 'Password'),  // Decoration for password input
            ),
            SizedBox(height: 32.0),  // SizedBox for adding spacing
            ElevatedButton(  // ElevatedButton widget for signup action
              onPressed: () {  // Callback function when button is pressed
                Navigator.pushNamed(context, '/login');  // Navigate to login page
                print('Signup Successful: ${_emailController.text}');  // Print signup success message
              },
              child: Text('Signup'),  // Button text
            ),
            SizedBox(height: 16.0),  // SizedBox for adding spacing
            TextButton(  // TextButton widget for navigation
              onPressed: () {  // Callback function when button is pressed
                Navigator.pushNamed(context, '/login');  // Navigate to login page
              },
              child: Text('Already have an account? Log in'),  // Button text
            ),
          ],
        ),
      ),
    );
  }
}
