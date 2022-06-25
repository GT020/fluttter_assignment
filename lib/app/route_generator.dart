import 'package:bima_doctor_admin/app/route_constants.dart';
import 'package:bima_doctor_admin/model/doctor.dart';
import 'package:bima_doctor_admin/views/doctor_view.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;
    final Doctor doctor = args as Doctor;
    switch (routeSettings.name) {
      case AppRoute.doctorRoute:
        return MaterialPageRoute(
            builder: (context) => DoctorView(
                  doctor: doctor,
                ));

      default:
        return errorRoute();
    }
  }

  static Route<dynamic> errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return const Scaffold(
        body: Center(child: Text("Error")),
      );
    });
  }
}
