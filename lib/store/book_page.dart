import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../home_page.dart';
import 'book_provider.dart';

class BookPage extends StatelessWidget {
  final Book book;

  BookPage(this.book);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.teal,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image(
              image: AssetImage(book.imageUrl),
              height: 300,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                book.title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                book.author,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[600],
                ),
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '\$${book.price.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                book.description,
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: InkWell(
                onTap: () {
                  // Handle "see more" action
                },
                child: Text(
                  'See more...',
                  style: TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Container(
              height: 50,
              margin: EdgeInsets.all(16),
              child: ElevatedButton.icon(
                onPressed: () {
                  // Access the BookProvider
                  final bookProvider =
                      Provider.of<BookProvider>(context, listen: false);

                  // Add the book to the cart
                  bookProvider.addToCart(book);

                  // Navigate to the CartPage
                  Navigator.pushNamed(context, '/cart');
                },
                icon: Icon(Icons.add_shopping_cart),
                label: Text(
                  'Add to Cart',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
