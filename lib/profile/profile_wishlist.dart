import 'package:flutter/material.dart';

class ProfileWishlist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Wishlist'),
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
              "Oops, there's nothing currently on your favorite list",
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
