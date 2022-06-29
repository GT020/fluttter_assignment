import 'package:bima_doctor_admin/model/doctor.dart';
import 'package:bima_doctor_admin/repository/doctors_repository.dart';
import 'package:bima_doctor_admin/views/doctor_view.dart';
import 'package:bima_doctor_admin/views/view_controller/home_view_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeViewControllerProvider = Provider(
  (ref) {
    return HomeViewController();
  },
);

final doctorListProvider = StreamProvider((ref) {
  return ref.read(homeViewControllerProvider).doctorListBehaviorSubject;
});
