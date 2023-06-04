import 'package:flutter/material.dart';
import 'cart/cart_page.dart';
import 'profile/profile_Page.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'store/store_page.dart';

void main() {
  runApp(HomeScreen());
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => GetStartedScreen(),
        '/home': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen(),
        '/store': (context) => StorePage(),
        '/cart': (context) => CartPage(),
        '/profile': (context) => ProfilePage(),
      },
    );
  }
}

class GetStartedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Get Started')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the login and signup screen
            Navigator.pushNamed(context, '/login');
          },
          child: Text('Get Started'),
        ),
      ),
    );
  }
}
