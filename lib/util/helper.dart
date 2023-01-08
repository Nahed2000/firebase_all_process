import 'package:flutter/material.dart';

mixin Helper {
  showSnackBar({
    required BuildContext context,
    required String message,
    required bool error,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            message,
            style: const TextStyle(fontSize: 18),
          ),
        ),
        backgroundColor: error ? Colors.red : Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
