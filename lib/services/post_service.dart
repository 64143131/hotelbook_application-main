import 'dart:convert';

import 'package:hotelbook_application/config/app.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PostService {
  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();

  static Future<dynamic> fetchPages() async {
    final response = await http.get(
      Uri.parse('$API_URL/api/posts'),
      headers: {'Content-Type': 'application/json'},
    );
    return jsonDecode(response.body);
  }

  static Future<dynamic> fetchPage(String id) async {
    final response = await http.get(
      Uri.parse('$API_URL/api/posts/$id'),
      headers: {'Content-Type': 'application/json'},
    );
    return jsonDecode(response.body);
  }
}
