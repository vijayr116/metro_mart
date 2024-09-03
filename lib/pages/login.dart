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
  bool _obscureText = true;

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
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
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
                        "If you don't have an account ",
                        style: TextStyle(color: Colors.black),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUp()));
                        },
                        child: const Text(
                          "Register Now",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Consumer<AuthProvider>(
                    builder: (context, value, child) {
                      if (value.isAuthenticate) {
                        Future.microtask(() => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage())));
                        // value.clearError();
                      }
                      return GestureDetector(
                        onTap: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            final username = _usernameController.text;
                            final password = _passwordController.text;
                            value.login(username, password);
                          }
                        },
                        child: Container(
                          color: Colors.black87,
                          width: 180,
                          height: 30,
                          alignment: Alignment.center,
                          child: value.isLoading
                              ? const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 1,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      'Authenticating...',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                )
                              : const Text(
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
