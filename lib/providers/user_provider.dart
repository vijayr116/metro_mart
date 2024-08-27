import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserProvider extends ChangeNotifier {
  bool _isAuthenticate = false;
  bool get authenticate => _isAuthenticate;

  var _users = [];
  get users => _users;
  //Get User Data
  loadData() async {
    final url = Uri.parse("http://localhost:8080/api/get");
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        // print(data[1]['name']);
        _users = data;
        print(_users);
      }
      notifyListeners();
    } catch (e, s) {
      print(e);
    }
  }
}
