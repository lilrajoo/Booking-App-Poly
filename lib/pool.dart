// Import necessary packages
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting

// Import custom widgets
import 'current_time_widget.dart';
import 'survey.dart';

// Define the PoolScreen widget
class PoolScreen extends StatefulWidget {
  const PoolScreen({Key? key}) : super(key: key); // Constructor

  @override
  State<PoolScreen> createState() => _PoolScreenState(); // Create state
}

// Define the state for PoolScreen
class _PoolScreenState extends State<PoolScreen> {
  // State variables
  DateTime selectedDate = DateTime.now()
      .add(const Duration(days: 1)); // Default selected date (tomorrow)
  String selectedCourt = ''; // Selected Court
  int? selectedTimeSlotIndex; // Selected time slot index

  // Generate a list of available dates (next 6 days)
  final List<DateTime> availableDates = List.generate(
      6,
      (index) => DateTime.now()
          .add(Duration(days: index + 1))); // Create a list of dates

  // List of available time slots
  final List<String> availableTimeSlots = [
    '10 - 11am',
    '11 - 12pm',
    '12 - 1pm',
    '1 - 2pm',
    '2 - 3pm',
    '3 - 4pm'
  ]; // Define time slots

  @override
  Widget build(BuildContext context) {
    // Build the UI
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Pool S10243484C'), // Title
            CurrentTimeWidget(), // Display current time
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Display Pool image
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                  child: Image.asset('images/Pool.png', height: 120.0),
                ),
              ),
              // Date selection options
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Wrap(
                    spacing: 10.0, // Horizontal spacing
                    runSpacing: 10.0, // Vertical spacing
                    children: _buildDateSelectionOptions(context),
                  ),
                ),
              ),
              // Court selection buttons
              Column(
                children: _buildCourtSelectionButtons(context),
              ),
              const SizedBox(height: 20),
              // Time selection buttons
              Column(
                children: _buildTimeSelectionButtons(context),
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
                onPressed: _handleBookingRequest,
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
    // Generate RadioListTile widgets for each available date
    return List.generate(availableDates.length, (index) {
      return SizedBox(
        width: (MediaQuery.of(context).size.width / 2) - 30,
        child: RadioListTile<DateTime>(
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
    // Generate ElevatedButton widgets for each court
    return List.generate(4, (index) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: selectedCourt == 'Lane ${index + 1}'
                ? Theme.of(context).colorScheme.primary // Update button color
                : Theme.of(context).colorScheme.surface,
            minimumSize: const Size(double.infinity, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
          ),
          onPressed: () {
            setState(() {
              selectedCourt = 'Lane ${index + 1}'; // Update selected court
            });
          },
          child: Text(
            'Lane ${index + 1}',
            style: TextStyle(
              color: selectedCourt == 'Lane ${index + 1}'
                  ? Theme.of(context).colorScheme.onPrimary // Update text color
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
    // Generate ElevatedButton widgets for time slots
    return List.generate(end - start, (index) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: selectedTimeSlotIndex == start + index
              ? Theme.of(context).colorScheme.primary // Update button color
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
          availableTimeSlots[start + index],
          style: TextStyle(
            color: selectedTimeSlotIndex == start + index
                ? Theme.of(context).colorScheme.onPrimary // Update text color
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
        'facility': 'Pool',
        'date': DateFormat('EEEE, MMM d').format(selectedDate), // Format date
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
        Navigator.of(context).pop(bookingDetails);
      }
    } else {
      // Show error message in snackbar if not all fields are filled
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select Day, Time & Lane"),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
