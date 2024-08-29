import 'package:flutter/material.dart';
import 'package:metro_mart/pages/home.dart';

import 'package:metro_mart/pages/sign_up.dart';
import 'package:metro_mart/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // @override
  // void initState() {
  //   super.initState();
  //   context.read<UserProvider>().logout();
  // }

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
                          "Register Now",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  // Consumer<AuthProvider>(
                  //   builder: (context, value, child) => GestureDetector(
                  //     onTap: () {
                  //       if (_formKey.currentState?.validate() ?? false) {
                  //         final username = _usernameController.text;
                  //         final password = _passwordController.text;
                  //         print('Username: $username');
                  //         print('Password: $password');
                  //         value.login(username, password);
                  //         if (value.isAuthenticate == true) {
                  //           Navigator.push(
                  //               context,
                  //               MaterialPageRoute(
                  //                   builder: (context) => const HomePage()));
                  //         }
                  //       }
                  //     },
                  //     child: Container(
                  //       color: Colors.black87,
                  //       width: 130,
                  //       height: 30,
                  //       alignment: Alignment.center,
                  //       child: const Text(
                  //         "Log In",
                  //         style: TextStyle(color: Colors.white),
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  Consumer<AuthProvider>(
                    builder: (context, value, child) {
                      if (value.isAuthenticate) {
                        Future.microtask(() => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage())));
                      }
                      return GestureDetector(
                        onTap: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            final username = _usernameController.text;
                            final password = _passwordController.text;
                            print('Username: $username');
                            print('Password: $password');
                            value.login(username, password);
                          }
                        },
                        child: value.isLoading
                            ? const CircularProgressIndicator()
                            : Container(
                                color: Colors.black87,
                                width: 130,
                                height: 30,
                                alignment: Alignment.center,
                                child: const Text(
                                  "Log In",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                      );
                    },
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
