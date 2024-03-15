import 'package:flutter/material.dart';  // Importing Flutter Material package for UI
import 'package:shared_preferences/shared_preferences.dart';  // Importing shared_preferences package for managing app preferences
import 'package:cineflix/screens/login_page.dart';  // Importing LoginPage for handling user login
import 'package:cineflix/screens/home_screen.dart';  // Importing HomeScreen for the main application screen

void main() {  // Entry point of the application
  runApp(MyApp());  // Running the main application widget
}

class MyApp extends StatelessWidget {  // MyApp class, the root widget of the application
  @override
  Widget build(BuildContext context) {  // Build method to construct the application UI
    return MaterialApp(  
      title: 'Cineflix',  
      theme: ThemeData.dark().copyWith(  
        scaffoldBackgroundColor: Colors.black,  
        primaryColor: Colors.blue,  
        hintColor: Colors.blueAccent,  
      ),
      home: FutureBuilder<SharedPreferences>(  // FutureBuilder to handle asynchronous operations
        future: SharedPreferences.getInstance(),  
        builder: (context, snapshot) {  
          if (snapshot.hasData) {  
            final isLoggedIn = snapshot.data?.getBool('isLoggedIn') ?? false;  
            if (isLoggedIn) {  // If user is logged in, navigate to HomeScreen
              return const HomeScreen();  // Returning HomeScreen widget
            }
          }
          return const LoginPage();  // If user is not logged in, navigate to LoginPage
        },
      ),
    );
  }
}
