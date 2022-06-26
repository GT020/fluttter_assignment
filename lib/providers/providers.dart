import 'package:bima_doctor_admin/model/doctor.dart';
import 'package:bima_doctor_admin/repository/doctors_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final doctorRepositoryProvider = Provider(
  (ref) {
    return DoctorsRepositoryImpl();
  },
);

final doctorListProvider = StreamProvider((ref) {
  return ref.read(doctorRepositoryProvider).doctorListController.stream;
});
