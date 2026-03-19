import 'package:flutter/material.dart';

import 'current_time_widget.dart';
import 'facility_map.dart'; // Import the facility map screen
import 'theme.dart'; // Import the custom theme for the app

void main() {
  runApp(const MyApp()); // Run the MyApp widget as the root of the application
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NP Facility Booking',

      theme: theme,
      initialRoute: '/login', // Ensure the initial route is set to '/login'
      routes: {
        '/login': (context) => const LoginScreen(),
        '/facility_map': (context) => const FacilityMapScreen(),
        // Define routes for other screens if needed
      },
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;

  final String _validUsername = '1';
  final String _validPassword = '1';

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacementNamed(context, '/facility_map');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login Successful!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // Space out title and time widget
          children: [
            Text(
              'NP Facility Booking S10243484C',
              style: TextStyle(fontSize: 17),
            ), // Title of the screen
            CurrentTimeWidget(), // Widget to display current time
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0),
                child: Image.asset('images/np_logo.png', height: 100.0),
              ),
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your username';
                  } else if (value != _validUsername) {
                    return 'Invalid username';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  } else if (value != _validPassword) {
                    return 'Invalid password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 7),
              ElevatedButton(
                onPressed: _handleLogin,
                child: const Text('Login'),
              ),
              const SizedBox(height: 7),
            ],
          ),
        ),
      ),
    );
  }
}
