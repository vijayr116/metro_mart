import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:metro_mart/constants.dart';

class AuthProvider extends ChangeNotifier {
  var _isAuthenticate = false;
  var _isLoading = false;

  bool get isAuthenticate => _isAuthenticate;
  bool get isLoading => _isLoading;

  Future<void> login(String uname, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final url = Uri.parse(myUrl);
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': uname,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        _isAuthenticate = data['is_active'];
        print('Login successfusssl');
      } else {
        print(response.statusCode);
        print('Login failed');
      }
    } catch (e, s) {
      print(s);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  logout() {
    _isAuthenticate = false;
    notifyListeners();
  }
}
