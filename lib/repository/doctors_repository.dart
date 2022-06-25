import 'dart:convert';
import 'dart:developer';

import 'package:bima_doctor_admin/api_provider/doctor_api.dart';
import 'package:bima_doctor_admin/model/doctor.dart';
import 'package:hive/hive.dart';

abstract class DoctorsRepository {
  Future<List<Doctor>> getAllDoctors();
}

class DoctorsRepositoryImpl implements DoctorsRepository {
  late final Box doctorHiveBox;
  late DoctorProviderApi _doctorProviderApi;
  DoctorsRepositoryImpl() {
    _doctorProviderApi = DoctorProviderApiImpl();
    doctorHiveBox = Hive.box('doctors');
  }
  @override
  Future<List<Doctor>> getAllDoctors() async {
    final List<dynamic> doctorsJsonList =
        await _doctorProviderApi.getDoctorList();

    List<Doctor> doctors = doctorsJsonList.map((dynamic doctorJson) {
      return Doctor.fromJson(doctorJson);
    }).toList();
    return doctors; 
  }

  Future<void> savedEditedDoctor(Doctor doctor) async {
    try {
      doctorHiveBox.put(doctor.id, doctor);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<Doctor>> getSavedDoctors(int id) async {
    final int length = doctorHiveBox.length;
    final List<Doctor> doctors = [];
    for (int i = 0; i < length; i++) {
      doctors.add(doctorHiveBox.getAt(i));
    }
    return doctors;
  }
}
