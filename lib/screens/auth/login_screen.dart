import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import '../../utils/form_field_validator.dart' as ffv;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final ffv.FormFieldValidator _formFieldValidator = ffv.FormFieldValidator();

  Future<void> _login() async {
    if (_loginFormKey.currentState!.validate()) {
      // Perform login logic here
      print("Email: ${_emailController.text}");
      print("Password: ${_passwordController.text}");
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(50.0),
        child: Form(
          key: _loginFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Glamour Grove Cosmetics',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF149EDD), // Bluish color
                ),
              ),
              AspectRatio(
                aspectRatio: 4 / 3,
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 40.0),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: UnderlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: _formFieldValidator.emailValidator,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: UnderlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 32.0),
              Column(
                children: [
                  SizedBox(
                    width: double.infinity, // Full width of the parent
                    child: ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(8.0), // Border radius
                        ),
                      ),
                      child: Text('Login'),
                    ),
                  ),
                  SizedBox(height: 32.0), // Spacing between the buttons
                  SizedBox(
                    width: double.infinity, // Full width of the parent
                    child: ElevatedButton(
                      onPressed: () async {},
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(8.0), // Border radius
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/google.svg',
                            // Path to your Google SVG icon
                            height: 24.0,
                            width: 24.0,
                          ),
                          SizedBox(width: 12),
                          // Spacing between the icon and the text
                          Text(
                            'Sign with Google',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
