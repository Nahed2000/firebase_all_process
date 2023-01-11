import 'dart:async';

import 'package:firebase_all_process/firebase/controller/fb_auth_acontroller.dart';
import 'package:flutter/material.dart';

class LunchScreen extends StatefulWidget {
  const LunchScreen({Key? key}) : super(key: key);

  @override
  State<LunchScreen> createState() => _LunchScreenState();
}

class _LunchScreenState extends State<LunchScreen> {
  late StreamSubscription streamSubscription;

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(const Duration(seconds: 2), () {
      streamSubscription =
          FbAuthController().checkUserStatus(({required bool loggedIn}) {
        String rout = loggedIn ? 'notesScreen' : 'loginScreen';
        Navigator.pushReplacementNamed(context, rout);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          'All Firebase Process',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
