import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyConstants {
  var loginUrl = "http://192.168.1.8:8080/metromart/api/login";
  var emulatorUrl = "http://10.0.2.2:8080/api/get";
  var loginApi = "http://192.168.1.4:8080/login";
  var registerApi = "http://192.168.1.4:8080/register";

  var sampleApi = "https://reqres.in/api/register";

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
    );
  }
}
