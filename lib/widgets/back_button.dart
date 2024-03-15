import 'package:flutter/material.dart';  // Importing Flutter Material package for UI

import '../colors.dart';  // Importing colors.dart file for color constants

// Class for a custom back button widget
class BackBtn extends StatelessWidget {
  const BackBtn({  // Constructor for BackBtn widget
    super.key,  // Super key property
  });

  @override
  Widget build(BuildContext context) {  // Build method to define the UI of the widget
    return Container(  // Container widget for back button
      height: 70,  // Height of the container
      width: 70,  // Width of the container
      margin: const EdgeInsets.only(top: 16, left: 16),  // Margin around the container
      decoration: BoxDecoration(  // Decoration for the container
        color: Colours.scaffoldBgColor,  // Background color from colors.dart
        borderRadius: BorderRadius.circular(8),  // Rounded corners with 8px radius
      ),
      child: IconButton(  // IconButton widget for back button
        onPressed: () {  // Callback function when button is pressed
          Navigator.pop(context);  // Navigate back to the previous screen
        },
        icon: const Icon(  // Icon widget for arrow back icon
          Icons.arrow_back_rounded,  // Arrow back icon
        ),
      ),
    );
  }
}
