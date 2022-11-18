import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_fitness_track/model/routine_model.dart';
import 'package:flutter_fitness_track/services/base_api.dart';
import 'package:flutter_fitness_track/services/interceptor_service.dart';

class RoutineAPI {
  final dio = Dio(
    BaseOptions(
      // baseUrl: '${BaseAPI().baseURL}/routine',
      baseUrl: '${BaseAPI().baseURL}/routine',
      connectTimeout: 5000,
      receiveTimeout: 10000,
    ),
  )..interceptors.add(JWTInterceptors());
}

class RoutineService extends RoutineAPI {
  Future<List<RoutineModel>> getAllRoutine() async {
    try {
      Response<List> response = await dio.get(
        '/',
      );

      List? data = response.data;
      List<RoutineModel> listOfRoutine =
          List<RoutineModel>.from(data!.map((e) => RoutineModel.fromJson(e)));

      return listOfRoutine;
    } catch (err) {
      rethrow;
    }
  }

  Future<String?> addNewRoutine(RoutineModel routine) async {
    print("addnewRoutine: ${(routine)}");
    try {
      Response response = await dio.post('/', data: (routine));

      Map data = response.data as Map;
      return data['message'];
    } catch (err) {
      rethrow;
    }
  }
}
