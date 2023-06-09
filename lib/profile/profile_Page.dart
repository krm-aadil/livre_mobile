import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:livre_mobile/profile/view_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../home_page.dart';
import '../store/store_page.dart';
import '../cart/cart_page.dart';
import '../profile/profile_wishlist.dart';
import '../profile/profile_orders.dart';
import '../profile/about_us.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _currentIndex = 3;

  String? _imagePath; // Added

  @override
  void initState() {
    super.initState();
    // Retrieve the saved image path from shared preferences
    _getImagePath();
  }

  Future<void> _getImagePath() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString('imagePath');
    setState(() {
      _imagePath = imagePath;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Center(
          child: Text(
            'User Profile Management',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        automaticallyImplyLeading:
            false, // Add this line to remove the back arrow
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Center(
              child: CircleAvatar(
                radius: 100,
                backgroundImage: _imagePath != null && _imagePath!.isNotEmpty
                    ? Image.file(File(_imagePath!)).image
                    : AssetImage('assets/login.png'),
              ),
            ),
            SizedBox(height: 16),
            ProfileSection(
              title: 'My Wishlist',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileWishlist(),
                  ),
                );
              },
            ),
            ProfileSection(
              title: 'My Orders',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileOrders(),
                  ),
                );
              },
            ),
            ProfileSection(
              title: 'View Profile',
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewProfile(),
                  ),
                );
                if (result == true) {
                  _getImagePath();
                }
              },
            ),
            ProfileSection(
              title: 'About Us',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AboutUs(),
                  ),
                );
              },
            ),
            SizedBox(height: 24),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                ),
                label: Text(
                  'Sign Out',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  primary: Colors.teal,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ],
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
              tabBorderRadius: 30,
              tabActiveBorder: Border.all(color: Colors.teal, width: 1),
              tabBorder: Border.all(color: Colors.teal, width: 1),
              tabShadow: [BoxShadow(color: Colors.teal, blurRadius: 0)],
              curve: Curves.easeOutExpo,
              duration: Duration(milliseconds: 250),
              gap: 8,
              color: Color.fromARGB(255, 255, 255, 255),
              activeColor: Colors.black,
              iconSize: 30,
              tabBackgroundColor: Colors.black.withOpacity(0.1),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              selectedIndex: _currentIndex,
              onTabChange: (index) {
                switch (index) {
                  case 0:
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            HomePage(FirebaseAuth.instance.currentUser!),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          var begin = Offset(1.0, 0.0);
                          var end = Offset.zero;
                          var curve = Curves.ease;
                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                      ),
                    );
                    break;
                  case 1:
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            StorePage(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          var begin = Offset(1.0, 0.0);
                          var end = Offset.zero;
                          var curve = Curves.ease;
                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                      ),
                    );
                    break;
                  case 2:
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            CartPage(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          var begin = Offset(1.0, 0.0);
                          var end = Offset.zero;
                          var curve = Curves.ease;
                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                      ),
                    );
                    break;
                  case 3:
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

class ProfileSection extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const ProfileSection({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
