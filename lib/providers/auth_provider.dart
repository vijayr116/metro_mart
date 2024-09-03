import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:metro_mart/constants.dart';

class AuthProvider extends ChangeNotifier {
  var _isAuthenticate = false;
  var _isLoading = false;

  var _isSignInAuthenticate = false;
  var _isSignLoading = false;

  bool get isAuthenticate => _isAuthenticate;
  bool get isLoading => _isLoading;

  bool get isSignInAuthenticate => _isSignInAuthenticate;
  bool get isSingLoading => _isSignLoading;

  Future<void> login(String uname, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final url = Uri.parse(MyConstants().loginApi);
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
        // var data = json.decode(response.body);
        print(response.body);
        _isAuthenticate = true;
        print('Login successfusssl');
      } else {
        MyConstants().showToast("Invalid credentials");
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

  Future<void> register(String uname, String password) async {
    _isSignLoading = true;
    notifyListeners();

    try {
      final url = Uri.parse(MyConstants().registerApi);
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
        // var data = json.decode(response.body);
        print(response.body);
        _isSignInAuthenticate = true;
        print('Register successfusssl');
        MyConstants().showToast("Registration Success");
      } else {
        print(response.statusCode);
        MyConstants().showToast("User already exists");
        print('Register failed');
      }
    } catch (e, s) {
      print(s);
    } finally {
      _isSignLoading = false;
      notifyListeners();
    }
  }

  logout() {
    _isSignInAuthenticate = false;
    _isAuthenticate = false;
    notifyListeners();
  }
}
