import 'package:flutter/material.dart';
import 'package:metro_mart/pages/login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _genderController = TextEditingController();
  final _dobController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _dobController.text = "${picked.toLocal()}".split(' ')[0];
      });
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
            "Sign Up",
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
                    decoration: const InputDecoration(
                        labelText: 'Username',
                        icon: Icon(Icons.person_outline)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                        labelText: 'Password', icon: Icon(Icons.lock)),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _genderController,
                    decoration: const InputDecoration(
                        labelText: 'Gender', icon: Icon(Icons.person)),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                        labelText: 'Email Id', icon: Icon(Icons.email)),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Email Id';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _dobController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today),
                      labelText: "Select Date",
                    ),
                    readOnly: true, // Prevents editing of the text field
                    onTap: () => _selectDate(context),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        // Perform login action
                        final username = _usernameController.text;
                        final password = _passwordController.text;
                        final dob = _dobController.text;
                        final email = _emailController.text;
                        final gender = _genderController.text;

                        // Handle authentication logic here
                        print('Username: $username');
                        print('Password: $password');
                        print('Username: $dob');
                        print('Password: $email');
                        print('Username: $gender');

                        Navigator.pop(context);
                      }
                      // fetchData();
                    },
                    child: Container(
                      color: Colors.black87,
                      width: 130,
                      height: 30,
                      alignment: Alignment.center,
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.white),
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
