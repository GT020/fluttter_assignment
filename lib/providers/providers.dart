import 'package:bima_doctor_admin/model/doctor.dart';
import 'package:bima_doctor_admin/repository/doctors_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final doctorRepositoryProvider = Provider(
  (ref) {
    return DoctorsRepositoryImpl();
  },
);
final doctorListProvider = FutureProvider((ref) async {
  List<Doctor> doctors =
      await ref.read(doctorRepositoryProvider).getAllDoctors();
  return doctors;
});
