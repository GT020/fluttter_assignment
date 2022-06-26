import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bima_doctor_admin/api_provider/doctor_api.dart';
import 'package:bima_doctor_admin/model/doctor.dart';
import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';

abstract class DoctorsRepository {
  Future<void> getAllDoctors();
}

class DoctorsRepositoryImpl implements DoctorsRepository {
  final BehaviorSubject<List<Doctor>> doctorListController =
      BehaviorSubject<List<Doctor>>();
  late final Box doctorHiveBox;
  late DoctorProviderApi _doctorProviderApi;
  DoctorsRepositoryImpl() {
    _doctorProviderApi = DoctorProviderApiImpl();
    doctorHiveBox = Hive.box('doctors');
    getAllDoctors();
  }
  @override
  Future<void> getAllDoctors() async {
    final List<dynamic> doctorsJsonList =
        await _doctorProviderApi.getDoctorList();

    List<Doctor> doctors = doctorsJsonList.map((dynamic doctorJson) {
      return Doctor.fromJson(doctorJson);
    }).toList();
    final savedEditedDoctors = getSavedDoctors();
    if (savedEditedDoctors.isNotEmpty) {
      final List<int?> editedIds = savedEditedDoctors.map((Doctor doctor) {
        return doctor.id;
      }).toList();
      for (int? id in editedIds) {
        doctors.removeWhere((element) => element.id == id);
      }
      doctors.addAll(savedEditedDoctors);
    }
    doctors.sort((Doctor a, Doctor b) => a.id!.compareTo(b.id!));
    doctorListController.add(doctors);
  }

  Future<void> savedEditedDoctor(Doctor doctor) async {
    try {
      doctorHiveBox.put(doctor.id, doctor);
    } catch (e) {
      log(e.toString());
    }
    List<Doctor> doctors = await doctorListController.stream.first;
    doctors.removeWhere((Doctor d) => d.id == doctor.id);
    doctors.add(doctor);
    doctors.sort((Doctor a, Doctor b) => a.id!.compareTo(b.id!));
    doctorListController.add(doctors);
  }

  List<Doctor> getSavedDoctors() {
    final int length = doctorHiveBox.length;
    final List<Doctor> doctors = [];
    for (int i = 0; i < length; i++) {
      doctors.add(doctorHiveBox.getAt(i));
    }
    return doctors;
  }
}
