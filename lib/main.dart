import 'package:flutter/material.dart';
import 'package:livre_mobile/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'cart/cart_page.dart';
import 'profile/profile_page.dart';
import 'store/store_page.dart';
import 'store/book_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // initialize Firebase

  runApp(
    ChangeNotifierProvider(
      create: (context) => BookProvider(), // create an instance of BookProvider
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        '/store': (context) => StorePage(),
        '/cart': (context) => CartPage(),
        '/profile': (context) => ProfilePage(),
      },
    );
  }
}
