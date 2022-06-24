import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class DoctorProviderApi {
  Future<List> getDoctorList();
}

class DoctorProviderApiImpl implements DoctorProviderApi {
  late Dio _dio;
  final String _doctorPath =
      'https://5efdb0b9dd373900160b35e2.mockapi.io/contacts';
  DoctorProviderApiImpl() {
    _dio = Dio();
  }
  @override
  Future<List> getDoctorList() async {
    try {
      final response = await _dio.get(_doctorPath);
      return response.data;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}
