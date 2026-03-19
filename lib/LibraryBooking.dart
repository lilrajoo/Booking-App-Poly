// Import necessary Flutter and third-party packages
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting dates

// Import custom widgets
import 'current_time_widget.dart'; // Displays the current time
import 'survey.dart'; // For navigating to the survey screen

// Define a stateful widget for the library booking screen
class LibraryBookingScreen extends StatefulWidget {
  final String facilityName; // Store the facility name as a parameter

  // Constructor to initialize the facilityName
  const LibraryBookingScreen({Key? key, required this.facilityName})
      : super(key: key);

  @override
  // Create the mutable state for this widget
  State<LibraryBookingScreen> createState() => _LibraryBookingScreenState();
}

// Define the mutable state for the LibraryBookingScreen widget
class _LibraryBookingScreenState extends State<LibraryBookingScreen> {
  // Initialize the selected date to tomorrow
  DateTime selectedDate = DateTime.now().add(const Duration(days: 1));
  String selectedOption = ''; // Store the selected room option
  int? selectedTimeSlotIndex; // Store the index of the selected time slot

  // Generate a list of available dates (next 6 days)
  final List<DateTime> availableDates = List.generate(
    6,
    (index) => DateTime.now().add(Duration(days: index + 1)),
  );

  // Define available time slots
  final List<String> availableTimeSlots = [
    '10 - 11am',
    '11 - 12pm',
    '12 - 1pm',
    '1 - 2pm',
    '2 - 3pm',
    '3 - 4pm'
  ];

  @override
  // Build the widget tree for this screen
  Widget build(BuildContext context) {
    return Scaffold(
      // Create the app bar
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                // Display facility name and "Student ID" in the app bar
                '${widget.facilityName} S10243484C',
                overflow: TextOverflow.ellipsis, // Handle text overflow
              ),
            ),
            const CurrentTimeWidget(), // Display current time widget
          ],
        ),
      ),
      // Create the body of the screen
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Display the facility image
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                  child: Image.asset(
                    // Load facility image dynamically based on facility name
                    'images/${widget.facilityName.toLowerCase().replaceAll(' ', '_')}.png',
                    height: 120.0,
                    width: 250,
                  ),
                ),
              ),
              // Display date selection options
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Wrap(
                    spacing: 10.0,
                    runSpacing: 10.0,
                    children: _buildDateSelectionOptions(context),
                  ),
                ),
              ),
              // Display room selection options
              Column(
                children: _buildOptionSelectionButtons(context),
              ),
              const SizedBox(height: 20),
              // Display time selection options
              Column(
                children: _buildTimeSelectionButtons(context),
              ),
              const SizedBox(height: 20),
              // Display the "Book Now" button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: _handleBookingRequest, // Handle booking when pressed
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

  // Build date selection options for the next 6 days
  List<Widget> _buildDateSelectionOptions(BuildContext context) {
    return List.generate(availableDates.length, (index) {
      return SizedBox(
        width: (MediaQuery.of(context).size.width / 2) - 30,
        child: RadioListTile<DateTime>(
          title: Text(
            DateFormat('EEEE, MMM d').format(availableDates[index]),
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          value: availableDates[index],
          groupValue: selectedDate,
          onChanged: (date) {
            setState(() {
              selectedDate = date!; // Update selected date when changed
            });
          },
        ),
      );
    });
  }

  // Build room selection buttons
  List<Widget> _buildOptionSelectionButtons(BuildContext context) {
    final options = ['Room 1', 'Room 2', 'Room 3', 'Room 4'];
    return List.generate(options.length, (index) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            // Change button color based on selection
            backgroundColor: selectedOption == options[index]
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.surface,
            minimumSize: const Size(double.infinity, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
          ),
          onPressed: () {
            setState(() {
              selectedOption = options[index]; // Update selected room
            });
          },
          child: Text(
            options[index],
            style: TextStyle(
              // Change text color based on selection
              color: selectedOption == options[index]
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

  // Build time selection buttons
  List<Widget> _buildTimeSelectionButtons(BuildContext context) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _buildTimeSlotButtons(context, 0, 3), // First row: 10am - 1pm
      ),
      const SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _buildTimeSlotButtons(context, 3, 6), // Second row: 1pm - 4pm
      ),
    ];
  }

  // Build individual time slot buttons
  List<Widget> _buildTimeSlotButtons(BuildContext context, int start, int end) {
    return List.generate(end - start, (index) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          // Change button color based on selection
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
          availableTimeSlots[start + index],
          style: TextStyle(
            // Change text color based on selection
            color: selectedTimeSlotIndex == start + index
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    });
  }

  // Handle the booking request when "Book Now" is pressed
  void _handleBookingRequest() async {
    if (selectedOption.isNotEmpty && selectedTimeSlotIndex != null) {
      // Create a map of booking details
      final bookingDetails = {
        'facility': widget.facilityName,
        'date': DateFormat('EEEE, MMM d').format(selectedDate),
        'time': availableTimeSlots[selectedTimeSlotIndex!],
        'court': selectedOption,
      };

      // Navigate to the survey screen and wait for the result
      final surveyResult = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SurveyScreen(bookingDetails: bookingDetails),
        ),
      );

      // If survey result is not null and is a Map<String, String>
      if (surveyResult != null && surveyResult is Map<String, String>) {
        // Combine booking details with survey results
        final result = {...bookingDetails, ...surveyResult};
        // Return result to previous screen (LibraryPage)
        // without the ... before the bookingDetails, code wont pop back to the map page correctly
        Navigator.of(context).pop(result);
      }
    } else {
      // Show an error message if not all options are selected
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select Day, Time & Room"),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
