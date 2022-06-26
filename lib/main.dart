import 'package:bima_doctor_admin/app/route_constants.dart';
import 'package:bima_doctor_admin/app/route_generator.dart';
import 'package:bima_doctor_admin/firebase_options.dart';
import 'package:bima_doctor_admin/model/doctor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  await Hive.initFlutter();
  Hive.registerAdapter(DoctorAdapter());
  await Hive.openBox('doctors');
  runApp(const ProviderScope(child: DoctorAdminApp()));
}

class DoctorAdminApp extends StatefulWidget {
  const DoctorAdminApp({Key? key}) : super(key: key);

  @override
  State<DoctorAdminApp> createState() => _DoctorAdminAppState();
}

class _DoctorAdminAppState extends State<DoctorAdminApp> {
  final firebaseAuthInstance = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      initialRoute: AppRoute.startUpRoute,
      onGenerateRoute: RouteGenerator.generateRoute,
      title: 'Doctor Admin',
    );
  }
}
