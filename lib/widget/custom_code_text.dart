import 'package:flutter/material.dart';

class CustomCodeText extends StatelessWidget {
  const CustomCodeText({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.onPress,
  }) : super(key: key);

  final TextEditingController controller;
  final FocusNode focusNode;
  final void Function(String value) onPress;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: TextField(
      controller: controller,
      focusNode: focusNode,
      textAlign: TextAlign.center,
      cursorColor: Colors.blueGrey,
      maxLength: 1,
      keyboardType: const TextInputType.numberWithOptions(
        decimal: false,
        signed: false,
      ),
      onChanged: onPress,
      decoration: InputDecoration(
        counterText: '',
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    ));
  }
}
