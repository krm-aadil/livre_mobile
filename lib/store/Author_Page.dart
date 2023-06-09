import 'package:flutter/material.dart';

class AuthorPage extends StatelessWidget {
  final String authorName;
  final String authorBio;

  const AuthorPage({
    required this.authorName,
    required this.authorBio,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal, // Set the app bar color to teal
        title: Text(authorName),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                SizedBox(
                  width: 150, // Adjust the width of the image
                  height: 150, // Adjust the height of the image
                  child: Image.asset(
                      'assets/login.png'), // Replace 'path_to_your_image' with the actual image asset path
                ),
                SizedBox(height: 16),
                Text(
                  "Oops! Sorry, the books haven't been categorized yet",
                  style: TextStyle(
                    color: Colors.teal, // Set the text color to teal
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
