import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class DataService {
  static Future<Map<String, dynamic>> fetchData() async {
    final jsonString = await rootBundle.loadString('assets/data.json');
    final data = json.decode(jsonString);
    return data;
  }
}

Future<Map<String, dynamic>> loadDataFromJson() async {
  String jsonData = await rootBundle.loadString('assets/data.json');
  Map<String, dynamic> data = json.decode(jsonData);
  return data;
}
