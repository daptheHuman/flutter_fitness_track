import 'package:flutter_fitness_track/model/routine_model.dart';

class HistoryModel {
  HistoryModel({
    required this.userId,
    required this.routineId,
    required this.startDate,
    required this.endDate,
    required this.routine,
  });
  late final String userId;
  late final String routineId;
  late final String startDate;
  late final String endDate;
  late final List<ExerciseModel> routine;

  HistoryModel.fromJson(Map<String, dynamic> json) {
    userId = json['_id'];
    routineId = json['routineId'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    if (json['routine'] != []) {
      routine = List.from(json['routine'])
          .map((e) => ExerciseModel.fromJson(e))
          .toList();
    } else {
      routine = List.empty(growable: true);
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = userId;
    data['routineId'] = routineId;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['routine'] = routine.isNotEmpty
        ? routine.map((e) => e.toJson()).toList()
        : List.empty(growable: true);
    return data;
  }
}
