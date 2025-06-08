import 'package:cabify/Screens/user/screens/find_trip/screens/find_trip_screen.dart';
import 'package:cabify/Screens/links.dart';
import 'package:cabify/Screens/user/screens/signup.dart';
import 'package:cabify/core/cache/cache_helper.dart';
import 'package:cabify/core/dependancy_injection/dependancy_injection.dart';
import 'package:flutter/material.dart';
import 'package:cabify/model/crud.dart'; // Import the Crud class
import 'package:cabify/model/statusrequest.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import the StatusRequest model

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controllers for the text fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Form key for validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Track loading state for UI
  bool isLoading = false;

  // Instance of the Crud class
  final Crud crud = Crud();

  Future<void> login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      // Prepare login data
      final Map<String, dynamic> data = {
        "email": emailController.text,
        "password": passwordController.text,
      };

      // Call the login API
      final response = await crud.postData(
        linkLogin,
        data,
      );

      setState(() {
        isLoading = false;
      });

      // Handle the API response
      response.fold(
        (status) {
          // Handle error based on StatusRequest enum
          if (status == StatusRequest.offlinefailure) {
            _showMessage('No internet connection');
          } else if (status == StatusRequest.serverfailure) {
            _showMessage('Server error occurred');
          } else if (status == StatusRequest.failure) {
            _showMessage('Login failed');
          }
        },
        (data) async {
          // Handle successful login response
          if (data.containsKey('token') && data.containsKey('passenger')) {
            String token = data['token']; // Save the token if needed
            var passenger = data['passenger']; // Access passenger data
            String passengerId =
                passenger['passengerId'].toString(); // Get passenger ID

            // Save token and passenger ID to SharedPreferences
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('token', token);
            await prefs.setString(
                'passengerId', passengerId); // Store the ID for later use
            locator<CacheHelper>().saveData(key: 'userId', value: passengerId);
            _showMessage('Login successful');

            // Navigate to Home screen after successful login
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const FindTripScreen()),
            );
          } else {
            // Handle unsuccessful login response (e.g., invalid credentials)
            _showMessage('Invalid email or password');
          }
        },
      );
    }
  }

  // Method to show error/success messages
  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Header with image and title
            Stack(
              children: [
                Container(
                  height: 300,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/gg.png'), // Replace with your background image path
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Positioned(
                  top: 50,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Icon(
                        Icons.directions_bus_filled,
                        size: 100,
                        color: Colors.white,
                      ),
                      Text(
                        '3ALA EL-TAREEZ',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Travel easily',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Form Section
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Create An Account',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Email TextField with validation
                    buildTextField(
                      'E-mail',
                      'Type your text here...',
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        // Basic email validation
                        if (!RegExp(
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$')
                            .hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Password TextField with validation
                    buildTextField(
                      'Enter password',
                      'Type your text here...',
                      isPassword: true,
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        // Password validation for length (minimum 6 characters)
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Login Button
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 80, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: login,
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : const Text(
                                'Login',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupScreen()),
                        );
                      },
                      child: const Center(
                          child: Text('Dont Have Account ? Signup')),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build TextFormField with controller and validation
  Widget buildTextField(
    String label,
    String hint, {
    bool isPassword = false,
    required TextEditingController controller,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.grey[200],
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }
}
