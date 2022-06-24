import 'package:bima_doctor_admin/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: DoctorAdminApp()));
}

class DoctorAdminApp extends StatelessWidget {
  const DoctorAdminApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Doctor Admin', home: HomeView());
  }
}
