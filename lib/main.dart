import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glamour_grove_cosmetics_app/screens/auth/login_screen.dart';
import 'package:glamour_grove_cosmetics_app/screens/home_screen.dart';
import 'package:glamour_grove_cosmetics_app/utils/network_utils.dart';

import 'controllers/auth_controller.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  /*// Initialize AuthController
  Get.put(AuthController());

  // Check for internet connection
  NetworkUtils networkUtils = NetworkUtils();
  await networkUtils.checkConnectionAndProceed();*/

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( // Use GetMaterialApp here
      initialBinding: BindingsBuilder(() {
        Get.put(AuthController()); // Bind AuthController
      }),
      initialRoute: '/login', // Define the initial route
      getPages: [
        GetPage(name: '/login', page: () => const LoginScreen()), // Define login screen
        GetPage(name: '/home', page: () => const HomeScreen()),   // Define home screen
      ],
    );
  }
}
