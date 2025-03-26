import 'dart:convert';
import 'package:assessment/models/user_model.dart';
import 'package:http/http.dart' as http;


class ApiService {
  static const String _baseUrl = "https://api.thenotary.app/customer/login";

  static Future<UserModel> fetchServices() async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': 'nandhakumar1411@gmail'}),
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load services');
}
  }
}