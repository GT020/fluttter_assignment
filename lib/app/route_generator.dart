import 'package:bima_doctor_admin/app/route_constants.dart';
import 'package:bima_doctor_admin/model/doctor.dart';
import 'package:bima_doctor_admin/views/doctor_view.dart';
import 'package:bima_doctor_admin/views/home_view.dart';
import 'package:bima_doctor_admin/views/login_view.dart';
import 'package:bima_doctor_admin/views/otp_view.dart';
import 'package:bima_doctor_admin/views/startup_view.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;

    switch (routeSettings.name) {
      case AppRoute.startUpRoute:
        return MaterialPageRoute(builder: (_) => const StartUpView());

      case AppRoute.homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case AppRoute.doctorRoute:
        {
          late final Doctor doctor = args as Doctor;
          return MaterialPageRoute(
              builder: (context) => DoctorView(
                    doctor: doctor,
                  ));
        }

      case AppRoute.loginRoute:
        return MaterialPageRoute(builder: (context) =>  LoginView());

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
