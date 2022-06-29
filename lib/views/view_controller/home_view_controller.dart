import 'dart:math';

import 'package:bima_doctor_admin/model/doctor.dart';
import 'package:bima_doctor_admin/repository/doctors_repository.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewController {
  late final DoctorsRepository doctorsRepository;
  final BehaviorSubject<List<Doctor>> doctorListBehaviorSubject =
      BehaviorSubject<List<Doctor>>();

  HomeViewController() {
    doctorsRepository = DoctorsRepositoryImpl();
    initializeDoctors();
  }

  void initializeDoctors() async {
    List<Doctor> doctors = await doctorsRepository.getAllDoctors();

    if (doctors.isEmpty) {
      doctorListBehaviorSubject.addError("Doctors not Found");
    } else {
      doctorListBehaviorSubject.add(doctors);
    }
  }

  void saveDoctor(Doctor doctor) async {
    doctorsRepository.savedEditedDoctor(doctor);
    List<Doctor> doctors = await doctorListBehaviorSubject.stream.first;
    doctors.removeWhere((Doctor d) => d.id == doctor.id);
    doctors.add(doctor);
    doctors.sort((Doctor a, Doctor b) => a.id!.compareTo(b.id!));
    doctorListBehaviorSubject.add(doctors);
    doctorListBehaviorSubject.listen((value) {
      print(value.toString());
    });
  }
}
