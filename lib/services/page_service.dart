import 'dart:convert';

import 'package:hotelbook_application/config/app.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PageService {
  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();

  static Future<dynamic> fetchPages() async {
    final response = await http.get(
      Uri.parse('$API_URL/api/pages'),
      headers: {'Content-Type': 'application/json'},
    );
    return jsonDecode(response.body);
  }

  static Future<dynamic> fetchPage(String id) async {
    final response = await http.get(
      Uri.parse('$API_URL/api/pages/$id'),
      headers: {'Content-Type': 'application/json'},
    );
    return jsonDecode(response.body);
  }
}
