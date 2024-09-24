import 'package:flutter/material.dart';

class CSB {
 static void customSnackBar(BuildContext context,
      {required Color messageBackgroundColor, required String message, int duration = 5}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: messageBackgroundColor,
        content: SizedBox(
          height: 25.0,
          child: Center(
              child: Text(
                message,
                style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              )),
        ),
        duration:  Duration(seconds: duration),
        shape: const StadiumBorder(),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(10), // Adjust margin
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      ),
    );
  }
}
