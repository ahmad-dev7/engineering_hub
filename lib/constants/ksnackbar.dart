import 'package:get/get.dart';
import 'package:flutter/material.dart';

class KSnackBar {
  final String message;
  KSnackBar(this.message);

  void success() {
    Get.snackbar(
      "Congratulations",
      message,
      duration: const Duration(seconds: 5),
      colorText: Colors.white,
      backgroundColor: Colors.green,
      barBlur: 50,
    );
  }

  void failed() {
    Get.snackbar(
      "Oops",
      message,
      messageText: Text(
        message,
        style:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
      colorText: Colors.white,
      duration: const Duration(seconds: 5),
      backgroundColor: const Color(0xFFBB2419),
      barBlur: 10,
    );
  }
}
