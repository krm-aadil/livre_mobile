import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        backgroundColor: Colors.teal, // Set app bar color to teal
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[200], // Set background color
            borderRadius: BorderRadius.circular(12), // Add rounded border
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'LIVRE',
                style: TextStyle(
                  color: Colors.teal, // Set 'L' color to teal
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                'At Livre, we believe that books have the power to inspire, educate, and transform lives. Our journey began with a simple idea: to create a haven for book lovers of all ages and backgrounds, where they can browse through a vast collection of books from all genres and authors. We strive to offer the best possible selection of books and provide exceptional service to our customers.\n\nOur team consists of passionate and knowledgeable book lovers who are dedicated to helping you find the perfect book. Whether you\'re looking for the latest bestsellers, a classic novel, or a children\'s book to read to your little ones, we have it all. Our book clubs, author events, and book signings provide a platform for readers to connect with each other and engage with their favorite authors.\n\nAt Livre, we value diversity, inclusivity, and sustainability. We are committed to making reading accessible to everyone and supporting local initiatives that promote literacy. Our packaging materials are eco-friendly, and we take great care to minimize our environmental impact.\n\nWe invite you to visit us at our store and experience the joy of reading. You can also browse and purchase books through our mobile app, and we offer free delivery on orders over \$50. If you have any questions or feedback, please don\'t hesitate to contact us. Thank you for choosing Livre as your go-to bookstore.',
                style: TextStyle(
                  color: Colors.black, // Set text color to black
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
