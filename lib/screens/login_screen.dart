import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../home_page.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;

      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        // User logged in successfully
        // You can perform additional actions here

        // Navigate to the home page after login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(userCredential.user!),
          ),
        );

        // Clear the text fields
        _emailController.clear();
        _passwordController.clear();
      } catch (e) {
        // Handle any errors that occurred during login
        setState(() {
          _errorMessage = 'Invalid email or password';
        });
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
          body: Stack(
            children: [
              // Top half - Image
              Container(
                height: orientation == Orientation.portrait
                    ? MediaQuery.of(context).size.height * 0.55
                    : MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/login.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Bottom half - Form
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: orientation == Orientation.portrait
                      ? MediaQuery.of(context).size.height * 0.5
                      : MediaQuery.of(context).size.height,
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 20.0),
                        // Email address field
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: 'Email Address',
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.0),
                        // Password field
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.0),
                        // Error message
                        Text(
                          _errorMessage,
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        // Login button
                        ElevatedButton(
                          onPressed: _login,
                          child: Text('Log In'),
                        ),
                        SizedBox(height: 10.0),
                        // Create an account text
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Create an account',
                            style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Image in the bottom right corner
              Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset(
                  'assets/bottom.png',
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
