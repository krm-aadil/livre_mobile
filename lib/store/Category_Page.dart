import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  final String categoryName;
  final String categoryDescription;

  const CategoryPage({
    required this.categoryName,
    required this.categoryDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal, // Set the app bar color to teal
        title: Text(categoryName), // Display the category name in the app bar
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
                      'assets/login.png'), // Set the image asset path
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
