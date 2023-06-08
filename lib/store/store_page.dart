import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import '../cart/cart_page.dart';
import '../home_page.dart';
import '../profile/profile_page.dart';
import 'Author_Page.dart';
import 'Category_Page.dart';
import 'data_service.dart';

class StorePage extends StatefulWidget {
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  int _currentIndex = 1;
  bool showCategories = true; // Variable to track the displayed content
  List<dynamic> authors = [];
  List<dynamic> categories = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    Map<String, dynamic> data = await DataService.fetchData();
    setState(() {
      authors = data['authors'];
      categories = data['categories'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              showCategories = true; // Show categories
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            primary: showCategories
                                ? Colors.teal
                                : Colors.transparent,
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                bottomLeft: Radius.circular(8.0),
                              ),
                            ),
                          ),
                          child: Text('Categories'),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              showCategories = false; // Show authors
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            primary: !showCategories
                                ? Colors.teal
                                : Colors.transparent,
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(8.0),
                                bottomRight: Radius.circular(8.0),
                              ),
                            ),
                          ),
                          child: Text('Authors'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              padding: EdgeInsets.all(16),
              children: showCategories
                  ? categories.map((item) {
                      return CircleImage(
                        image: AssetImage(item['image']),
                        label: item['name'],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoryPage(
                                categoryName: item['name'],
                                categoryDescription: item['description'],
                              ),
                            ),
                          );
                        },
                      );
                    }).toList()
                  : authors.map((item) {
                      return CircleImage(
                        image: AssetImage(item['image']),
                        label: item['name'],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AuthorPage(
                                authorName: item['name'],
                                authorBio: item['bio'],
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
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
                    // Stay on StorePage
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

class CircleImage extends StatelessWidget {
  final ImageProvider image;
  final String label;
  final VoidCallback onTap; // New callback

  const CircleImage({
    required this.image,
    required this.label,
    required this.onTap, // New parameter
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Wrap with GestureDetector for onTap handling
      onTap: onTap, // Pass the onTap callback
      child: Column(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: image,
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
