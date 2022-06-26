import 'package:bima_doctor_admin/views/home_view.dart';
import 'package:bima_doctor_admin/views/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StartUpView extends StatelessWidget {
  const StartUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data != null) {
            return const HomeView();
          } else {
            return const LoginView();
          }
        } else {
          return const LoginView();
        }
      },
    );
  }
}
