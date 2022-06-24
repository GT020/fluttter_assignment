import 'package:flutter/material.dart';

void main() {
  runApp(const DoctorAdminApp());
}

class DoctorAdminApp extends StatelessWidget {
  const DoctorAdminApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Doctor Admin',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Container());
  }
}
