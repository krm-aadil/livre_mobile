import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class ViewProfile extends StatefulWidget {
  @override
  _ViewProfileState createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    // Set the initial values of email and password controllers
    _emailController.text =
        'example@example.com'; // Replace with actual value from Firebase
    _passwordController.text =
        'password'; // Replace with actual value from Firebase

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
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: source);

    if (pickedImage != null) {
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final savedImage = File('${appDir.path}/$fileName.png');
      await savedImage.writeAsBytes(await pickedImage.readAsBytes());

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('imagePath', savedImage.path);

      setState(() {
        _imagePath = savedImage.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.teal),
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.teal),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 16),
            CircleAvatar(
              radius: 80,
              backgroundImage: _imagePath != null && _imagePath!.isNotEmpty
                  ? Image.file(File(_imagePath!)).image
                  : AssetImage('assets/login.png'),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    _pickImage(ImageSource.gallery);
                  },
                  icon: Icon(
                    Icons.image,
                    size: 24,
                    color: Colors.teal,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _pickImage(ImageSource.camera);
                  },
                  icon: Icon(
                    Icons.camera_alt,
                    size: 24,
                    color: Colors.teal,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                  SizedBox(height: 12),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      // Handle save button press
                      String newEmail = _emailController.text;
                      String newPassword = _passwordController.text;

                      // Update email and password using Firebase or any other backend service
                      // ...

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Profile saved')),
                      );
                    },
                    child: Text('Save'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.teal,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
