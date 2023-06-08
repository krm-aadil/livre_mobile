import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'cart/cart_page.dart';
import 'profile/profile_Page.dart';
import 'store/store_page.dart';

class HomePage extends StatelessWidget {
  final User user;

  HomePage(this.user);

  final List<Book> books = [];
  final List<Author> authors = [];

  Future<void> loadBooksAndAuthors(BuildContext context) async {
    // Load data from data.json file in assets
    String jsonData =
        await DefaultAssetBundle.of(context).loadString('assets/data.json');
    Map<String, dynamic> data = json.decode(jsonData);

    // Parse book data
    List<dynamic> bookData = data['books'];
    books.clear();
    for (var item in bookData) {
      books.add(Book.fromJson(item));
    }

    // Parse author data
    List<dynamic> authorData = data['authors'];
    authors.clear();
    for (var item in authorData) {
      authors.add(Author.fromJson(item));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: loadBooksAndAuthors(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: [
                      Text(
                        'Livre',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'The Book App for curious minds',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 200,
                  child: CarouselSlider(
                    items: books.map((book) {
                      return Image(
                        image: AssetImage(book.imageUrl),
                        fit: BoxFit.cover,
                      );
                    }).toList(),
                    options: CarouselOptions(
                      height: 200,
                      viewportFraction: 1.0,
                      enlargeCenterPage: false,
                      autoPlay: true,
                      aspectRatio: 2.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    'New Arrivals',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: books.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Handle book card click
                          // You can navigate to a book detail page or perform any other action
                        },
                        child: BookCard(book: books[index]),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    'Best Authors',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  height: 300,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: authors.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Handle author card click
                          // You can navigate to an author detail page or perform any other action
                        },
                        child: AuthorCard(author: authors[index]),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(0)),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.teal[800]!,
              hoverColor: Colors.teal[700]!,
              haptic: true,
              tabBorderRadius: 15,
              tabActiveBorder: Border.all(color: Colors.black, width: 1),
              tabBorder: Border.all(color: Colors.teal, width: 1),
              tabShadow: [
                BoxShadow(color: Colors.teal.withOpacity(0.5), blurRadius: 0)
              ],
              curve: Curves.easeOutExpo,
              duration: Duration(milliseconds: 250),
              gap: 8,
              color: Colors.teal[800],
              activeColor: Colors.black,
              iconSize: 24,
              tabBackgroundColor: Colors.black.withOpacity(0.1),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              selectedIndex: 0,
              onTabChange: (index) {
                switch (index) {
                  case 0:
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage(user)),
                    );
                    break;
                  case 1:
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => StorePage()),
                    );
                    break;
                  case 2:
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => CartPage()),
                    );
                    break;
                  case 3:
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()),
                    );
                    break;
                }
              },
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: LineIcons.store,
                  text: 'Store',
                ),
                GButton(
                  icon: LineIcons.shoppingCart,
                  text: 'Cart',
                ),
                GButton(
                  icon: LineIcons.user,
                  text: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BookCard extends StatelessWidget {
  final Book book;

  BookCard({required this.book});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 160,
            color: Colors.grey[300],
            child: Image(
              image: AssetImage(book.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8),
          Text(
            book.title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            book.author,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 4),
          Text(
            '\$${book.price.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class AuthorCard extends StatelessWidget {
  final Author author;

  AuthorCard({required this.author});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            color: Colors.grey[300],
            child: Image(
              image: AssetImage(author.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8),
          Text(
            author.name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            author.genre,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

class Book {
  final String title;
  final String author;
  final String imageUrl;
  final double price;

  Book({
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.price,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'],
      author: json['author'],
      imageUrl: json['image'],
      price: json['price'] != null ? json['price'].toDouble() : 0.0,
    );
  }
}

class Author {
  final String name;
  final String genre;
  final String imageUrl;

  Author({
    required this.name,
    required this.genre,
    required this.imageUrl,
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      name: json['name'] ?? '',
      genre: json['genre'] ?? '',
      imageUrl: json['image'] ?? '',
    );
  }
}
