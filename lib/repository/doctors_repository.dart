import 'dart:async';
import 'dart:developer';

import 'package:bima_doctor_admin/api_provider/doctor_api.dart';
import 'package:bima_doctor_admin/model/doctor.dart';
import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';

abstract class DoctorsRepository {
  Future<List<Doctor>> getAllDoctors();
  List<Doctor> getSavedDoctors();
  Future<void> savedEditedDoctor(Doctor doctor);
}

class DoctorsRepositoryImpl implements DoctorsRepository {
  late final Box doctorHiveBox;
  late DoctorProviderApi _doctorProviderApi;

  DoctorsRepositoryImpl() {
    _doctorProviderApi = DoctorProviderApiImpl();
    doctorHiveBox = Hive.box('doctors');
  }

  Future<List<Doctor>> getDoctorsFromApi() async {
    final List<dynamic> doctorsJsonList =
        await _doctorProviderApi.getDoctorList();

    return doctorsJsonList.map((dynamic doctorJson) {
      return Doctor.fromJson(doctorJson);
    }).toList();
  }

  @override
  Future<List<Doctor>> getAllDoctors() async {
    final List<Doctor> savedEditedDoctors = getSavedDoctors();

    List<Doctor> doctors = await getDoctorsFromApi();

    if (doctors.isEmpty) {
      return [];
    }

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

    return doctors;
  }

  @override
  Future<void> savedEditedDoctor(Doctor doctor) async {
    try {
      doctorHiveBox.put(doctor.id, doctor);
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  List<Doctor> getSavedDoctors() {
    final int length = doctorHiveBox.length;
    final List<Doctor> doctors = [];
    for (int i = 0; i < length; i++) {
      doctors.add(doctorHiveBox.getAt(i));
    }
    return doctors;
  }
}
