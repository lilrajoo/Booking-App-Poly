// Import necessary packages
import 'package:flutter/material.dart';

import 'LibraryBooking.dart'; // Import the library booking screen
import 'current_time_widget.dart'; // Import the custom widget to display current time

class LibraryPage extends StatelessWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Main scaffold widget
      appBar: AppBar(
        // App bar with title and current time widget
        title: const Text('Library S10243484C'), // Title text
        actions: const [
          CurrentTimeWidget(), // Display current time
        ],
      ),
      body: SingleChildScrollView(
        // Allows the screen to be scrollable
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20), // Add space before the image
              // Add the Library.png image at the top
              Image.asset(
                'images/Library.png',
                width: double.infinity,
                fit: BoxFit.cover,
                height: 200, // Set a specific height for consistency
              ),
              const SizedBox(height: 20), // Increase space after the image
              // Build a card for the Meeting Room facility
              _buildFacilityCard(
                context,
                image: 'images/meeting_room.png',
                facilityName: 'Meeting Room',
              ),
              // Build a card for the Study Room facility
              _buildFacilityCard(
                context,
                image: 'images/study_room.png',
                facilityName: 'Study Room',
              ),
              // Build a card for the Recording Room facility
              _buildFacilityCard(
                context,
                image: 'images/recording_room.png',
                facilityName: 'Recording Room',
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build a facility card
  Widget _buildFacilityCard(BuildContext context,
      {required String image, required String facilityName}) {
    return Padding(
      // Add vertical padding around the card
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        // Create a card with elevation
        elevation: 5,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 10), // Add space before the image
            Center(
              child: Image.asset(
                image, // Facility image
                height: 150.0, // Set a specific height for all facility images
                width: 300.0, // Set a specific width for all facility images
                fit:
                    BoxFit.cover, // Ensure the image fits within the dimensions
              ),
            ),
            const SizedBox(height: 10), // Add space after the image
            Center(
              child: Text(
                facilityName, // Facility name
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold), // Text style
              ),
            ),
            const SizedBox(height: 10), // Add space after the facility name
            Center(
              child: ElevatedButton(
                // Button to navigate to booking screen
                onPressed: () async {
                  // Navigate to the booking screen and await result
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LibraryBookingScreen(
                        facilityName: facilityName, // Pass facility name
                      ),
                    ),
                  );
                  if (result != null && result is Map<String, String>) {
                    // If booking completed successfully, return booking details
                    Navigator.of(context).pop(result);
                  }
                },
                child: const Text('Book Now'), // Button text
              ),
            ),
            const SizedBox(height: 15), // Add space after the button
          ],
        ),
      ),
    );
  }
}
