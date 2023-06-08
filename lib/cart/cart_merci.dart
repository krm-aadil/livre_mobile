import 'package:flutter/material.dart';
import '../store/store_page.dart';

class CartMerci extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline,
              color: Colors.teal,
              size: 80,
            ),
            SizedBox(height: 16),
            Text(
              'Merci! You have successfully purchased.',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StorePage(),
                  ),
                );
              },
              child: Text('Continue Shopping'),
              style: ElevatedButton.styleFrom(
                primary: Colors.teal,
                onPrimary: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
