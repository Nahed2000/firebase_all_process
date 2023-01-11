import 'dart:async';

import 'package:firebase_all_process/model/fb_response.dart';
import 'package:firebase_auth/firebase_auth.dart';

typedef UsersStatusCallBack = void Function({required bool loggedIn});

class FbAuthController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // This way not use
  bool get loggedIn => _firebaseAuth.currentUser != null;

  StreamSubscription checkUserStatus(UsersStatusCallBack usersStatusCallBack) {
    return _firebaseAuth.authStateChanges().listen((User? user) {
      usersStatusCallBack(loggedIn: user != null);
    });
  }

  //signIn
  Future<FbResponse> signInAccount(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        String message = userCredential.user!.emailVerified
            ? 'Logged in Successfully '
            : 'Please verification your account';
        return FbResponse(
            message: message, status: userCredential.user!.emailVerified);
      }
    } on FirebaseAuthException catch (e) {
      return errorException(e);
    }
    return FbResponse(message: 'Something went wrong', status: false);
  }

  // create account
  Future<FbResponse> createAccount(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        await userCredential.user!.sendEmailVerification();
        return FbResponse(
            message:
                'create account Successfully & send email verification ..!!',
            status: true);
      }
    } on FirebaseAuthException catch (firebaseAuthException) {
      return errorException(firebaseAuthException);
    } catch (e) {
      //
    }
    return FbResponse(message: 'Something went wrong ', status: false);
  }

  //logout
  Future<void> logout() async => await _firebaseAuth.signOut();

  // forget
  Future<FbResponse> forgetPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      return errorException(e);
    } catch (e) {
      //
    }
    return FbResponse(message: 'Something went wrong ', status: false);
  }

  FbResponse errorException(FirebaseAuthException firebaseAuthException) {
    if (firebaseAuthException.code == 'email-already-in-use') {
      //
    } else if (firebaseAuthException.code == 'invalid-email') {
      //
    } else if (firebaseAuthException.code == 'operation-not-allowed') {
      //
    } else if (firebaseAuthException.code == 'weak-password') {
      //
    } else if (firebaseAuthException.code == 'wrong-password') {
      //
    } else if (firebaseAuthException.code == 'user-not-found') {
      //
    } else if (firebaseAuthException.code == 'user-disabled') {
      //
    } else if (firebaseAuthException.code == 'invalid-email') {
      //
    } else if (firebaseAuthException.code == 'auth/invalid-email') {
      //
    } else if (firebaseAuthException.code == 'auth/user-not-found') {
      //
    }
    return FbResponse(
        message: firebaseAuthException.message ?? 'error occurred',
        status: false);
  }
}
