import 'package:firebase_all_process/bloc/crud_state.dart';
import 'package:firebase_all_process/bloc/image_bloc.dart';
import 'package:firebase_all_process/screen/auth/forget_password.dart';
import 'package:firebase_all_process/screen/auth/register_screen.dart';
import 'package:firebase_all_process/screen/notes/notes_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screen/auth/login_screen.dart';
import 'screen/images/images_screen.dart';
import 'screen/images/upolad_images.dart';
import 'screen/lunch_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ImageBloc(LoadingState()),
        )
      ],
      child: MaterialApp(
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const LunchScreen(),
          'loginScreen': (context) => const LoginScreen(),
          'registerScreen': (context) => const RegisterScreen(),
          'forgetScreen': (context) => const ForgetPassword(),
          'notesScreen': (context) => const NotesScreen(),
          'imagesScreen':(context) => const ImagesScreen(),
          'uploadImagesScreen':(context) => const UploadImagesScreen(),
        },
      ),
    );
  }
}
