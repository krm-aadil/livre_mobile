import 'package:flutter/material.dart';

import '../home_page.dart';

class BookAuthorPage extends StatelessWidget {
  final Author author;

  BookAuthorPage(this.author);

  @override
  Widget build(BuildContext context) {
    // Build the book author detail page UI using the provided author data
    // You can access the author properties like author.name, author.genre, etc.
    return Scaffold(
      appBar: AppBar(
        title: Text(author.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Book Author Page'),
            Text('Name: ${author.name}'),
            Text('Genre: ${author.genre}'),
          ],
        ),
      ),
    );
  }
}
