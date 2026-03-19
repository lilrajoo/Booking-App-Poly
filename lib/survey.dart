import 'package:flutter/material.dart';

import 'current_time_widget.dart';

class SurveyScreen extends StatefulWidget {
  final Map<String, String> bookingDetails;

  const SurveyScreen({Key? key, required this.bookingDetails})
      : super(key: key);

  @override
  SurveyScreenState createState() => SurveyScreenState();
}

class SurveyScreenState extends State<SurveyScreen> {
  String _facilityQuality = 'Good'; // Holds the selected quality rating
  String _appSatisfaction = 'Yes'; // Holds the selected app satisfaction rating

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // Space out title and time widget
          children: [
            Text('Survey S10243484C'), // Title of the screen
            CurrentTimeWidget(), // Widget to display current time
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0), // Padding for the whole body
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align items to the start
          children: [
            _buildQuestionSection(
              question:
                  'Please rate the quality of ${widget.bookingDetails['facility']}:', // Question based on facility
              options: ['Good', 'Bad'], // Options for rating

              groupValue: _facilityQuality, // Current selected value
              onChanged: (value) => setState(
                  () => _facilityQuality = value!), // Update state on change
            ),
            const SizedBox(height: 20), // Space between sections
            _buildQuestionSection(
              question:
                  'Are you satisfied with the application?', // Question for satisfaction
              options: ['Yes', 'No'], // Options for satisfaction
              groupValue: _appSatisfaction, // Current selected value
              onChanged: (value) => setState(
                  () => _appSatisfaction = value!), // Update state on change
            ),
            const SizedBox(height: 20), // Space between sections
            Center(
              child: ElevatedButton(
                onPressed: _submitSurvey, // Function to call on button press
                child: const Text('Submit Survey'), // Text on the button
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionSection({
    required String question, // The question to display
    required List<String> options, // Options for the question
    required String groupValue, // The currently selected value
    required void Function(String?)
        onChanged, // Function to call when an option is selected
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Align items to the start
      children: [
        Text(
          question, // Display the question
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold), // Text style for the question
        ),
        Column(
          children: options.map((option) {
            return RadioListTile<String>(
              title: Text(option), // Display each option
              value: option, // Value associated with the option
              groupValue: groupValue, // Current selected value
              onChanged:
                  onChanged, // Function to call when an option is selected
            );
          }).toList(),
        ),
      ],
    );
  }

  void _submitSurvey() {
    if (_facilityQuality.isNotEmpty && _appSatisfaction.isNotEmpty) {
      final surveyResults = {
        //apply survey results
        'facilityQuality': _facilityQuality,
        'appSatisfaction': _appSatisfaction,
      };

      final result = {...widget.bookingDetails, ...surveyResults};

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Survey Summary'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //display summary of results
                Text('Facility Quality: ${result['facilityQuality']}'),
                Text('App Satisfaction: ${result['appSatisfaction']}'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  //pop back to booking
                  Navigator.of(context).pop();
                  Navigator.of(context).pop(result);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please answer all questions"),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
