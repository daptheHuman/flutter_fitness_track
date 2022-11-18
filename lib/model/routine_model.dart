class RoutineModel {
  RoutineModel({
    this.id,
    required this.exercise,
    required this.name,
  });
  late List<ExerciseModel> exercise;
  late String name;
  String? id;

  RoutineModel.fromJson(Map<String, dynamic> json) {
    if (json['exercise'].isNotEmpty) {
      exercise = List.from(json['exercise'])
          .map((e) => ExerciseModel.fromJson(e))
          .toList();
    } else {
      exercise = List.empty(growable: true);
    }
    id = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['exercise'] = exercise.map((e) => e.toJson()).toList();
    data['name'] = name;
    return data;
  }
}

class ExerciseModel {
  ExerciseModel({
    required this.name,
    required this.sets,
    required this.reps,
    this.id,
  });
  late final String name;
  late final int sets;
  late final int reps;
  late final String? id;

  ExerciseModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    sets = (json['sets']);
    reps = (json['reps']);
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['sets'] = sets;
    data['reps'] = reps;
    if (id != null) data['_id'] = id;
    return data;
  }
}
