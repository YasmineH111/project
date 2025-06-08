import 'dart:developer';

import 'package:cabify/Screens/driver/SignupDriver.dart';
import 'package:cabify/Screens/driver/screens/add_trip/add_trip_screen.dart';
import 'package:cabify/Screens/driver/homeDriver.dart';
import 'package:cabify/Screens/links.dart';
import 'package:cabify/core/cache/cache_helper.dart';
import 'package:cabify/core/dependancy_injection/dependancy_injection.dart';
import 'package:flutter/material.dart';
import 'package:cabify/model/crud.dart';
import 'package:cabify/model/statusrequest.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginDriver extends StatefulWidget {
  const LoginDriver({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginDriver> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final Crud crud = Crud();

  Future<void> login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      final Map<String, dynamic> data = {
        "email": emailController.text,
        "password": passwordController.text,
      };
      final response = await crud.postData(
        linkLoginDriver,
        data,
      );
      setState(() {
        isLoading = false;
      });
      response.fold(
        (status) {
          if (status == StatusRequest.offlinefailure) {
            _showMessage('No internet connection');
          } else if (status == StatusRequest.serverfailure) {
            _showMessage('Server error occurred');
          } else if (status == StatusRequest.failure) {
            _showMessage('Login failed');
          }
        },
        (data) async {
          if (data.containsKey('token') && data.containsKey('driver')) {
            String token = data['token'];
            var driver = data['driver'];
            String driverId = driver['driverId'].toString();
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('token', token);
            await prefs.setString('driverId', driverId);
            _showMessage('Login successful');
            await locator<CacheHelper>()
                .saveData(key: "id", value: data["driver"]["driverId"]);
            log(data["driver"]["driverId"].toString());
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const AddTripScreen()),
            );
          } else {
            _showMessage('Invalid email or password');
          }
        },
      );
    }
  }

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
            Stack(
              children: [
                Container(
                  height: 300,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/gg.png'),
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
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Create An Driver Account',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 20),
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
                    buildTextField(
                      'Enter password',
                      'Type your text here...',
                      isPassword: true,
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
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
                              builder: (context) => SignupDriver()),
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
