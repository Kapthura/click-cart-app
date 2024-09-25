import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/logged_user.dart';
import '../utils/network_utils.dart';

class AuthController extends GetxController {
  Rxn<LoggedUser> loggedUser = Rxn<LoggedUser>();

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus(); // Now called directly without waiting for frame rendering.
  }

  // Check login status from SharedPreferences
  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    String? loggedUserData = prefs.getString('LoggedUser');

    if (loggedUserData != null) {
      // Decode user data
      final jsonData = jsonDecode(loggedUserData);
      loggedUser.value = LoggedUser.fromJson(jsonData);

      // User is logged in, proceed to home, but first check internet connectivity
      if (loggedUser.value?.isLoggedIn == true) {
        // Check internet connection in the background
        await _checkInternetAndNavigate('/home');
      } else {
        Get.offAllNamed('/login');
      }
    } else {
      // If no logged user data, navigate to login screen
      Get.offAllNamed('/login');
    }
  }

  // Check internet and then navigate to the intended screen
  Future<void> _checkInternetAndNavigate(String route) async {
    bool isConnected = await NetworkUtils.checkInternetConnectivity();
    if (isConnected) {
      Get.offAllNamed(route); // Navigate to the intended screen
    } else {
      // Show the login screen but inform the user that there's no internet
      Get.offAllNamed('/login');
      Get.snackbar('No Internet', 'You are not connected to the internet.');
    }
  }

  Future<void> login(LoggedUser user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('LoggedUser', jsonEncode(user.toJson()));
    Get.offAllNamed('/home');
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('LoggedUser');
    loggedUser.value = null;
    Get.offAllNamed('/login');
  }
}
