// Import necessary Flutter and third-party packages
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// Import custom screens for different facilities
import 'MA.dart';
import 'badminton.dart';
import 'bounce.dart';
import 'current_time_widget.dart';
import 'library.dart';
import 'pool.dart';
import 'squash.dart';

// Define a stateful widget for the facility map screen
class FacilityMapScreen extends StatefulWidget {
  const FacilityMapScreen({Key? key}) : super(key: key);

  // Create the mutable state for this widget
  @override
  State<FacilityMapScreen> createState() => _FacilityMapScreenState();
}

// Define the mutable state for the FacilityMapScreen
class _FacilityMapScreenState extends State<FacilityMapScreen> {
  // Set the initial camera position for the Google Map
  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(1.3347469604940612, 103.775887892338),
    zoom: 17.1,
  );

  // Define a map of facility locations with their coordinates
  final Map<String, LatLng> locations = {
    'Library': const LatLng(1.3335990788108378, 103.77701616913401),
    'Pool': const LatLng(1.335296911005291, 103.77680309821864),
    'Badminton Court': const LatLng(1.3361150244128437, 103.77713556789445),
    'Squash': const LatLng(1.3358116194483478, 103.7765846396834),
    'Bounce': const LatLng(1.3343595704445206, 103.77497665429638),
    'Makers Academy': const LatLng(1.3329800214983827, 103.77599526706558),
  };

  // Initialize an empty list to store bookings
  List<Map<String, String>> bookings = [];

  // Build the widget tree
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set up the app bar
      appBar: AppBar(
        title: const Text('NP Facility Map S10243484C'),
        actions: const [
          CurrentTimeWidget(), // Display current time
        ],
      ),
      // Set up the main body of the screen
      body: Column(
        children: [
          // Display the Google Map
          Expanded(
            flex: 3,
            child: GoogleMap(
              mapType: MapType
                  .satellite, //satellite view for btr view compared to normal :>
              initialCameraPosition: _kGooglePlex,
              markers: _createMarkers(context),
              liteModeEnabled: false, //kept for testing purposes
              zoomControlsEnabled: true, //move around easier
              mapToolbarEnabled: false,
              compassEnabled: true,
              myLocationButtonEnabled:
                  false, //no want this, keep location at np
            ),
          ),
          // Display booking summary wooo
          Expanded(
            flex: 2,
            child: ListView(
              children: [
                const Text(
                  'Booking Summary:',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 2),
                // Display the recent bookings, showing the last 7 bookings in reverse order, latest first :P
                ...bookings.reversed.take(5).map((booking) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Text(
                        '${booking['facility']}, ${booking['court'] ?? ''} on ${booking['date']} for ${booking['time']}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    )),
              ],
            ),
          ),
          // Display "Back to Login" button, so if finish booking, "log out"
          Container(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ), //look nicer :O
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
                //navigate to login
              },
              child: const Text(
                'Log Out', //text in button, logout like in bank apps ext :]
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Create markers for each facility location
  Set<Marker> _createMarkers(BuildContext context) {
    return locations.entries.map((entry) {
      return Marker(
        markerId: MarkerId(entry.key),
        position: entry.value,
        infoWindow: InfoWindow(
          title: entry.key,
          snippet: 'Book Now',
          onTap: () {
            _navigateToBookingScreen(context, entry.key);
          },
        ),
      );
    }).toSet();
  }

  // Navigate to the booking screen for the selected facility
  void _navigateToBookingScreen(BuildContext context, String location) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _getBookingScreen(location),
      ),
    );

    // If a booking is made, add it to the list of recent bookings
    if (result != null && result is Map<String, String>) {
      setState(() {
        bookings.add(result);
        if (bookings.length > 5) {
          bookings.removeAt(0); // Limit the bookings to the last 5 entries
        }
      });
    }
  }

  // Get the appropriate booking screen for the selected facility
  Widget _getBookingScreen(String location) {
    switch (location) {
      case 'Library':
        return const LibraryPage();
      case 'Pool':
        return const PoolScreen();
      case 'Badminton Court':
        return const BadmintonScreen();
      case 'Squash':
        return const SquashScreen();
      case 'Bounce':
        return const BounceScreen();
      case 'Makers Academy':
        return const MAScreen();
      default:
        return const Scaffold(body: Center(child: Text('Not Available')));
    }
  }
}
