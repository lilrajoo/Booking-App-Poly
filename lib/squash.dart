// Import necessary packages
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'current_time_widget.dart'; // Import the custom widget to display current time
import 'survey.dart'; // Import the survey screen

// Widget for the Squash Court Booking screen
class SquashScreen extends StatefulWidget {
  const SquashScreen({Key? key}) : super(key: key);

  @override
  State<SquashScreen> createState() => _SquashScreenState();
}

class _SquashScreenState extends State<SquashScreen> {
  // State variables
  DateTime selectedDate = DateTime.now()
      .add(const Duration(days: 1)); // Default selected date (tomorrow)
  String selectedCourt = ''; // Selected Court
  int? selectedTimeSlotIndex; // Selected time slot index

  // Generate a list of available dates (next 6 days)
  final List<DateTime> availableDates = List.generate(
      6, (index) => DateTime.now().add(Duration(days: index + 1)));

  // List of available time slots
  final List<String> availableTimeSlots = [
    '10 - 11am',
    '11 - 12pm',
    '12 - 1pm',
    '1 - 2pm',
    '2 - 3pm',
    '3 - 4pm'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Main scaffold widget
      appBar: AppBar(
        // App bar with title and current time widget
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Squash S10243484C'), // Title text
            CurrentTimeWidget(), // Widget to display current time
          ],
        ),
      ),
      body: SingleChildScrollView(
        // Allows the screen to be scrollable
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Display Squash image
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                  child: Image.asset('images/Squash.png', height: 120.0),
                ),
              ),
              // Date selection options
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Wrap(
                    spacing: 10.0,
                    runSpacing: 10.0,
                    children: _buildDateSelectionOptions(
                        context), // Date selection widgets
                  ),
                ),
              ),
              // Court selection buttons
              Column(
                children: _buildCourtSelectionButtons(
                    context), // Court selection widgets
              ),
              const SizedBox(height: 20),
              // Time selection buttons
              Column(
                children: _buildTimeSelectionButtons(
                    context), // Time selection widgets
              ),
              const SizedBox(height: 20),
              // Book Now button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: _handleBookingRequest, // Handle booking request
                child: const Text(
                  "Book Now",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Builds date selection options
  List<Widget> _buildDateSelectionOptions(BuildContext context) {
    return List.generate(availableDates.length, (index) {
      // Generate widgets for each date
      return SizedBox(
        width: (MediaQuery.of(context).size.width / 2) - 30,
        child: RadioListTile<DateTime>(
          // Radio button for selecting date
          title: Text(
            DateFormat('EEEE, MMM d')
                .format(availableDates[index]), // Format date
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          value: availableDates[index],
          groupValue: selectedDate,
          onChanged: (date) {
            setState(() {
              selectedDate = date!; // Update selected date
            });
          },
        ),
      );
    });
  }

  // Builds Court selection buttons
  List<Widget> _buildCourtSelectionButtons(BuildContext context) {
    return List.generate(4, (index) {
      // Generate buttons for each court
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: selectedCourt == 'Court ${index + 1}'
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.surface,
            minimumSize: const Size(double.infinity, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
          ),
          onPressed: () {
            setState(() {
              selectedCourt = 'Court ${index + 1}'; // Update selected court
            });
          },
          child: Text(
            'Court ${index + 1}', // Display court number
            style: TextStyle(
              color: selectedCourt == 'Court ${index + 1}'
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.onSurface,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    });
  }

  // Builds time selection buttons
  List<Widget> _buildTimeSelectionButtons(BuildContext context) {
    return [
      // First row of time slots
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _buildTimeSlotButtons(context, 0, 3),
      ),
      const SizedBox(height: 10),
      // Second row of time slots
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _buildTimeSlotButtons(context, 3, 6),
      ),
    ];
  }

  // Builds time slot buttons
  List<Widget> _buildTimeSlotButtons(BuildContext context, int start, int end) {
    return List.generate(end - start, (index) {
      // Generate buttons for each time slot
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: selectedTimeSlotIndex == start + index
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.surface,
          minimumSize: const Size(100, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
        ),
        onPressed: () {
          setState(() {
            selectedTimeSlotIndex = start + index; // Update selected time slot
          });
        },
        child: Text(
          availableTimeSlots[start + index], // Display time slot
          style: TextStyle(
            color: selectedTimeSlotIndex == start + index
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    });
  }

  // Handles the booking request
  void _handleBookingRequest() async {
    if (selectedCourt.isNotEmpty && selectedTimeSlotIndex != null) {
      // Create booking details
      final bookingDetails = {
        'facility': 'Squash',
        'date': DateFormat('EEEE, MMM d').format(selectedDate),
        'time': availableTimeSlots[selectedTimeSlotIndex!],
        'court': selectedCourt,
      };

      // Navigate to survey screen and await result
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SurveyScreen(bookingDetails: bookingDetails),
        ),
      );

      // If survey completed successfully, return booking details
      if (result != null && result is Map<String, String>) {
        Navigator.of(context).pop(
            bookingDetails); // Return to previous screen with booking details
      }
    } else {
      // Show error message if not all fields are filled
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select Day, Time & Court"), // Error message
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
