import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:metro_mart/pages/sign_up.dart';
import 'package:metro_mart/providers/user_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    context.read<UserProvider>().loadData();
  }

  void fetchData() async {
    final url = Uri.parse('http://10.0.2.2:8080/api/get');
    try {
      // Sending a GET request to the URL
      final response = await http.get(url);
      // Checking if the request was successful
      if (response.statusCode == 200) {
        // Decoding the JSON response
        final data = json.decode(response.body);
        print('Data fetched: $data');
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/METRO MART.png',
            height: 100,
            width: 100,
          ),
          const Text(
            "Sign In",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(labelText: 'Username'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "If you dont have account ",
                        style: TextStyle(color: Colors.black),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => const SignUp())));
                        },
                        child: const Text(
                          "Register Here",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Consumer<UserProvider>(
                    builder: (context, value, child) => GestureDetector(
                      onTap: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          // Perform login action
                          final username = _usernameController.text;
                          final password = _passwordController.text;
                          // Handle authentication logic here
                          print('Username: $username');
                          print('Password: $password');
                          // value.loadData(username, password);
                          for (var name in value.users) {
                            if (name['name'] == username) {
                              print("=========Can Naviagate to Home=========");
                              break;
                            } else {
                              print("Authentication failed");
                            }
                          }
                        }
                      },
                      child: Container(
                        color: Colors.black87,
                        width: 130,
                        height: 30,
                        alignment: Alignment.center,
                        child: const Text(
                          "Log In",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
