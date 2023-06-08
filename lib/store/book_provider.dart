import 'package:flutter/material.dart';
import '../home_page.dart';

class BookProvider extends ChangeNotifier {
  List<Book> cartBooks = [];

  void addToCart(Book book) {
    cartBooks.add(book);
    notifyListeners();
  }

  void removeFromCart(Book book) {
    cartBooks.remove(book);
    notifyListeners();
  }

  List<Book> getCartItems() {
    return cartBooks;
  }

  double getTotalAmount() {
    double total = 0;
    for (var book in cartBooks) {
      total += book.price;
    }
    return total;
  }
}
