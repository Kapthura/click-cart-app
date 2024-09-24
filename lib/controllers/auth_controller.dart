import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/logged_user.dart';

class AuthController extends GetxController {
  Rxn<LoggedUser> loggedUser = Rxn<LoggedUser>(); // Observable for LoggedUser

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus(); // Check login status on app start
  }

  // Check login status from SharedPreferences
  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    String? loggedUserData = prefs.getString('LoggedUser');

    if (loggedUserData != null) {
      // If there is logged user data, decode it to LoggedUser object
      final jsonData = jsonDecode(loggedUserData);
      loggedUser.value = LoggedUser.fromJson(jsonData);

      if (loggedUser.value?.isLoggedIn == true) {
        Get.offAllNamed('/home');
      } else {
        Get.offAllNamed('/login');
      }
    } else {
      Get.offAllNamed('/login');
    }
  }

  // Function to log in the user and save data to SharedPreferences
  Future<void> login(LoggedUser loggedUser) async {
    final prefs = await SharedPreferences.getInstance();

    // Save LoggedUser data to SharedPreferences
    await prefs.setString('LoggedUser', jsonEncode(loggedUser.toJson()));

    Get.offAllNamed('/home'); // Navigate to home screen after login
  }

  // Function to log out the user and remove data from SharedPreferences
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs
        .remove('LoggedUser'); // Remove LoggedUser data from SharedPreferences

    loggedUser.value = null; // Clear the loggedUser data
    Get.offAllNamed('/login'); // Navigate to login screen after logout
  }
}
