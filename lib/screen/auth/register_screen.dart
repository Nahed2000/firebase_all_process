import 'package:flutter/material.dart';
import 'package:firebase_all_process/util/helper.dart';

import '../../firebase/controller/fb_auth_acontroller.dart';
import '../../model/fb_response.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with Helper {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  // late TextEditingController _fullNameController;

  // String gender = 'M';

  @override
  void initState() {
    // TODO: implement initState
    _emailController = TextEditingController();
    // _fullNameController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    // _fullNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Register Screen',
          style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              letterSpacing: 2,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.s,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome...!!',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'please enter your email, password to register ,and your gender',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 40),
              // CustomTextField(
                // controller: _fullNameController,
                // title: 'Full Name',
              // ),
              // const SizedBox(height: 20),
              CustomTextField(
                controller: _emailController,
                title: 'Email',
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _passwordController,
                title: 'Password',
              ),
              const SizedBox(height: 20),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     Expanded(
              //       child: RadioListTile(
              //         value: 'M',
              //         groupValue: gender,
              //         onChanged: (String? value) {
              //           setState(() {
              //             if (value != null) {
              //               gender = value;
              //             }
              //           });
              //         },
              //         title: Text('Male'),
              //       ),
              //     ),
              //     Expanded(
              //       child: RadioListTile(
              //         value: 'F',
              //         groupValue: gender,
              //         onChanged: (String? value) {
              //           setState(() {
              //             if (value != null) {
              //               gender = value;
              //             }
              //           });
              //         },
              //         title: const Text('Female'),
              //       ),
              //     ),
              //   ],
              // ),
              CustomButton(
                  onPress: () async => await performRegister(),
                  title: 'Register'),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> performRegister() async {
    if (checkData()) {
      await register();
    }
  }

  bool checkData() {
    if (
    // _fullNameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(
      context: context,
      message: 'Please Enter your Email & Password & Full Name',
      error: true,
    );
    return false;
  }

  Future<void> register() async {
    FbResponse fbResponse = await FbAuthController().createAccount(
        email: _emailController.text, password: _passwordController.text);
    showSnackBar(
        context: context,
        message: fbResponse.message,
        error: !fbResponse.status);
    if (fbResponse.status) {
      Navigator.pop(context);
    }
  }
}
