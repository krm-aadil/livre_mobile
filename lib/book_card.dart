import 'package:flutter/material.dart';
import 'package:livre_mobile/home_page.dart';
import 'store/book_page.dart'; // Import the book detail page

class BookCard extends StatelessWidget {
  final String title;
  final String author;
  final String imageUrl;
  final double price;

  const BookCard({
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookPage(title as Book)),
        );
      },
      child: Container(
        width: 140,
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 41, 83, 74),
                    ),
                  ),
                  Positioned(
                    top: -8,
                    right: -3,
                    child: IconButton(
                      icon: Icon(
                        Icons.favorite_border,
                        color: Color.fromARGB(255, 7, 255, 230),
                        size: 20,
                      ),
                      onPressed: () {
                        // Handle favorite button click
                      },
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              author,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 4),
            Text(
              '\$${price.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
