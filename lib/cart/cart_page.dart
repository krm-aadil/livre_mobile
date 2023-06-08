import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../home_page.dart';
import '../store/store_page.dart';
import '../profile/profile_page.dart';
import 'cart_payments.dart';
import 'package:livre_mobile/store/book_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    // Access the BookProvider
    final bookProvider = Provider.of<BookProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Cart',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Livre',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Display cart items
          Consumer<BookProvider>(
            builder: (context, provider, _) {
              final cartItems = provider.getCartItems();
              return ListView.builder(
                shrinkWrap: true,
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final book = cartItems[index];
                  return Card(
                    elevation: 2,
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 100,
                            height: 120,
                            child: Image.asset(
                              book.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  book.title,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  book.author,
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '\$${book.price}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        // Handle move to wishlist button press
                                      },
                                      child: Text('Move to Wishlist'),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.teal,
                                        onPrimary: Colors.white,
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        // Remove the book from the cart
                                        provider.removeFromCart(book);
                                      },
                                      child: Text('Remove'),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.red,
                                        onPrimary: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
          Spacer(),
          Card(
            elevation: 2,
            margin: EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Amount: \$${bookProvider.getTotalAmount()}',
                    style: TextStyle(fontSize: 18),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartPayments(),
                        ),
                      );
                    },
                    child: Text('Place Order'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.teal,
                      onPrimary: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
              selectedIndex: _currentIndex,
              onTabChange: (index) {
                // Handle tab change
                switch (index) {
                  case 0:
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              HomePage(FirebaseAuth.instance.currentUser!)),
                    );
                    break;
                  case 1:
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => StorePage()),
                    );
                    break;
                  case 2:
                    // Stay on CartPage
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
