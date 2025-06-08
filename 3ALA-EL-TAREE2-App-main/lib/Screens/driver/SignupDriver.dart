import 'package:cabify/Screens/links.dart';
import 'package:cabify/Screens/driver/loginDriver.dart';
import 'package:cabify/core/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:cabify/model/crud.dart'; // Import your CRUD class
import 'package:cabify/model/statusrequest.dart';

class SignupDriver extends StatelessWidget {
  // Controllers for text fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController licenseNumber = TextEditingController();

  // Global Key for the form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Instance of Crud
  final Crud crud = Crud();

  SignupDriver({super.key});

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

                    // Email TextField
                    buildTextField(
                      'E-mail',
                      'Type your text here...',
                      emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                            .hasMatch(value)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Name TextField
                    buildTextField(
                      'Name',
                      'Type your text here...',
                      nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Mobile Number TextField
                    buildTextField(
                      'Mobile Number',
                      'Type your text here...',
                      mobileController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your mobile number';
                        } else if (!RegExp(r'^[0-9]{10,15}$').hasMatch(value)) {
                          return 'Enter a valid mobile number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    buildTextField(
                      'licenseNumber',
                      'Type your text here...',
                      licenseNumber,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your licenseNumber';
                        } else if (!RegExp(r'^[0-9]{10,15}$').hasMatch(value)) {
                          return 'Enter a valid licenseNumber';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Password TextField
                    buildTextField(
                      'Enter password',
                      'Type your text here...',
                      passwordController,
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Sign-Up Button
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
                        onPressed: () => signup(context),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, RouteNames.loginDriver);
                        },
                        child: const Text(
                          'Already have an account? Login',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                          ),
                        ),
                      ),
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
      String label, String hint, TextEditingController controller,
      {bool isPassword = false, String? Function(String?)? validator}) {
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
          validator: validator,
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
        ),
      ],
    );
  }

  Future<void> signup(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final data = {
        "email": emailController.text,
        "name": nameController.text,
        "mobileNumber": mobileController.text,
        "password": passwordController.text,
        "licenseNumber": licenseNumber.text,
      };

      try {
        debugPrint("Sending POST request to $linkSignup");
        debugPrint("Request body: $data");

        final response = await crud.postData(linkSignupDriver, data);

        response.fold(
          (status) {
            // Handle errors based on StatusRequest enum
            String errorMsg;
            switch (status) {
              case StatusRequest.offlinefailure:
                errorMsg =
                    'No internet connection. Please check your connection and try again.';
                break;
              case StatusRequest.serverfailure:
                errorMsg = 'Server error. Please try again later.';
                break;
              case StatusRequest.unauthorized:
                errorMsg =
                    'Unauthorized access. Please check your credentials.';
                break;
              case StatusRequest.forbidden:
                errorMsg =
                    'Forbidden. You do not have permission to perform this action.';
                break;
              case StatusRequest.notfound:
                errorMsg = 'Server endpoint not found. Please contact support.';
                break;
              case StatusRequest.failure:
                errorMsg = 'Email already in use. Please choose another one.';
                break;
              default:
                errorMsg = 'An unexpected error occurred. Please try again.';
            }

            // Log error status
            debugPrint("Error status: $status");
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(errorMsg)));
          },
          (responseData) {
            // Check if the response is the expected format
            if (responseData['status'] == 'ok') {
              // Registration successful
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Registration successful!')),
              );

              // Navigate to LoginScreen after successful registration
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginDriver()),
              );
            } else if (responseData == 'ok') {
              // If the response is just the string "ok"
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Registration successful!')),
              );

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginDriver()),
              );
            } else {
              // If the response is not in the expected format
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Server failure. Please try again.')),
              );
            }
          },
        );
      } catch (e) {
        // Catch and log any unexpected errors
        debugPrint("Unexpected error during signup: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('An unexpected error occurred. Please try again.')),
        );
      }
    }
  }
}
