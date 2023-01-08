import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key, required this.controller, required this.title})
      : super(key: key);

  final TextEditingController controller;

  final String title;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.blueGrey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.grey)),
          hintText: title,
          hintStyle: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.teal.shade900,fontSize: 14)),
    );
  }
}
