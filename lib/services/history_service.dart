import 'package:dio/dio.dart';
import 'package:flutter_fitness_track/model/history_model.dart';
import 'package:flutter_fitness_track/services/base_api.dart';
import 'package:flutter_fitness_track/services/interceptor_service.dart';

class HistoryAPI {
  final dio = Dio(
    BaseOptions(
      baseUrl: '${BaseAPI().baseURL}/history',
      connectTimeout: 5000,
      receiveTimeout: 10000,
    ),
  )..interceptors.add(JWTInterceptors());
}

class HistoryService extends HistoryAPI {
  Future<String> addHistory({required HistoryModel newHistory}) async {
    // print(newHistory);

    try {
      Response<Map> response = await dio.post('/', data: newHistory);

      String message = response.data!['message'];
      return message;
    } catch (err) {
      rethrow;
    }
  }

  Future<List<HistoryModel>> getHistroyRoutine(
      {required String routineId, required String userId}) async {
    try {
      Response<List> response = await dio.get('/routine/$routineId/$userId');

      List? data = response.data;
      List<HistoryModel> listOfHistory =
          List.from(data!.map((e) => HistoryModel.fromJson(e)));

      return listOfHistory;
    } catch (err) {
      rethrow;
    }
  }

  Future<List<HistoryModel>> getAllHistory({required String userId}) async {
    try {
      Response<List> response = await dio.get('/$userId');

      List? data = response.data;
      List<HistoryModel> listOfHistory =
          List.from(data!.map((e) => HistoryModel.fromJson(e)));

      return listOfHistory;
    } catch (err) {
      rethrow;
    }
  }
}
