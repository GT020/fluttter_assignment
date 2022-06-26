import 'package:bima_doctor_admin/app/route_generator.dart';
import 'package:bima_doctor_admin/model/doctor.dart';
import 'package:bima_doctor_admin/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(DoctorAdapter());
  await Hive.openBox('doctors');
  runApp(const ProviderScope(child: DoctorAdminApp()));
}

class DoctorAdminApp extends StatelessWidget {
  const DoctorAdminApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        onGenerateRoute: RouteGenerator.generateRoute,
        title: 'Doctor Admin',
        home: HomeView());
  }
}
