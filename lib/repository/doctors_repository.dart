import 'dart:convert';

import 'package:bima_doctor_admin/api_provider/doctor_api.dart';
import 'package:bima_doctor_admin/model/doctor.dart';

abstract class DoctorsRepository {
  Future<List<Doctor>> getAllDoctors();
}

class DoctorsRepositoryImpl implements DoctorsRepository {
  late bool isDataFetchedFromApi;
  late DoctorProviderApi _doctorProviderApi;
  DoctorsRepositoryImpl() {
    _doctorProviderApi = DoctorProviderApiImpl();
  }
  @override
  Future<List<Doctor>> getAllDoctors() async {
    final List<dynamic> doctorsJsonList =
        await _doctorProviderApi.getDoctorList();
    return doctorsJsonList.map((dynamic doctorJson) {
      return Doctor.fromJson(doctorJson);
    }).toList();
  }
}
