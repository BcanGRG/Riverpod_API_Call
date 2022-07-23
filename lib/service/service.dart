import 'dart:convert';

import 'package:riverpod_practise/model/model.dart';

import 'package:http/http.dart' as http;

class Service {
  static Future<UserModel?> fetchUser() async {
    Uri url = Uri.parse("https://reqres.in/api/users?page=2");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return UserModel.fromJson(jsonDecode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
