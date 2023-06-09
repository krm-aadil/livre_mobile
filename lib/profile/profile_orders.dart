import 'package:flutter/material.dart';

class ProfileOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
        backgroundColor: Colors.teal, // Set app bar color to teal
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/user.webp', // Replace with the actual image path
              width: 200,
              height: 200,
            ),
            SizedBox(height: 16),
            Text(
              "Oops, currently there have been no orders shipped to you",
              style: TextStyle(
                color: Colors.teal, // Set text color to teal
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
