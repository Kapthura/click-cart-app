import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'package:flutter_svg/svg.dart';
import '../../services/auth_service.dart';
import '../../utils/form_field_validator.dart' as ffv;
import '../common_widgets/custom_snack_bar.dart';
import '../home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = AuthService();
  final _loginFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final ffv.FormFieldValidator _formFieldValidator = ffv.FormFieldValidator();
  final _logger = Logger();
  bool isLoading = false;
  bool isLoadingGoogle = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: const EdgeInsets.all(50.0),
          child: Form(
            key: _loginFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Glamour Grove Cosmetics',
                  textAlign: TextAlign.center,
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
                const SizedBox(height: 40.0),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: UnderlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: _formFieldValidator.emailValidator,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
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
                const SizedBox(height: 32.0),
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity, // Full width of the parent
                      child: isLoading
                          ? const Column(
                              children: [
                                SizedBox(height: 10.0),
                                CircularProgressIndicator(),
                              ],
                            )
                          : ElevatedButton(
                              onPressed: _login,
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(8.0), // Border radius
                                ),
                              ),
                              child: const Text('Login'),
                            ),
                    ),
                    const SizedBox(height: 32.0), // Spacing between the buttons
                    SizedBox(
                      width: double.infinity, // Full width of the parent
                      child: isLoadingGoogle
                          ? const Column(
                              children: [
                                SizedBox(height: 10.0),
                                CircularProgressIndicator(),
                              ],
                            )
                          : ElevatedButton(
                              onPressed: _loginWithGoogle,
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
                                  const SizedBox(width: 12),
                                  // Spacing between the icon and the text
                                  const Text(
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
      ),
    );
  }

  Future<void> _login() async {
    if (_loginFormKey.currentState!.validate()) {
      _logger.i("Email: ${_emailController.text}");
      _logger.i("Password: ${_passwordController.text}");

      setState(() {
        isLoading = true;
      });
      final user = await _auth.loginUserWithEmailAndPassword(
          _emailController.text, _passwordController.text);

      setState(() {
        isLoading = false;
      });
      if (user != null) {
        _logger.i(user.toString());
        clearForm();
        if (!mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        if (!mounted) return;
        CSB.customSnackBar(context,
            messageBackgroundColor: Colors.redAccent.shade400,
            message: "Opps! That went wrong, Please try again in few minutes");
      }
    }
  }

  Future<void> _loginWithGoogle() async {
    setState(() {
      isLoadingGoogle = true;
    });
    final user = await _auth.loginWithGoogle();
    setState(() {
      isLoadingGoogle = false;
    });
    if (user != null) {
      _logger.i(user.toString());
      clearForm();
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      if (!mounted) return;
      CSB.customSnackBar(context,
          messageBackgroundColor: Colors.redAccent.shade400,
          message: "Opps! That went wrong, Please try again in few minutes");
    }
  }

  void clearForm() {
    _emailController.text = "";
    _passwordController.text = "";
  }
}
