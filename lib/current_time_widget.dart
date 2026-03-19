// Import necessary Flutter package
import 'package:flutter/material.dart';
// Import the one_clock package for the DigitalClock widget
import 'package:one_clock/one_clock.dart';

// Define a stateless widget for displaying the current time
class CurrentTimeWidget extends StatelessWidget {
  // Boolean to control whether seconds are displayed
  final bool showSeconds;

  // Constructor with named parameter
  const CurrentTimeWidget({
    Key? key,
    this.showSeconds = true, // Default to showing seconds
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Add horizontal padding to the widget
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Row(
        // Align the clock to the end (right) of the row
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Use the DigitalClock widget from the one_clock package
          DigitalClock(
            showSeconds: showSeconds, // Control seconds display
            isLive: true, // Update the time continuously
            digitalClockTextColor: Colors.white, // Set text color to white
          ),
        ],
      ),
    );
  }
}
