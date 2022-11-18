// class UserModel {
//   UserModel({
//     this.id,
//     required this.username,
//     required this.email,
//     required this.password,
//     required this.routine,
//     required this.history,
//   });
//   late final String? id;
//   late final String username;
//   late final String email;
//   late final String password;
//   late final List<Routine> routine;
//   late final List<History> history;

//   UserModel.fromJson(Map<String, dynamic> json) {
//     id = json['_id'];
//     username = json['username'];
//     email = json['email'];
//     password = json['password'];
//     routine =
//         List.from(json['routine']).map((e) => Routine.fromJson(e)).toList();
//     history =
//         List.from(json['history']).map((e) => History.fromJson(e)).toList();
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['_id'] = id;
//     _data['username'] = username;
//     _data['email'] = email;
//     _data['password'] = password;
//     _data['routine'] = routine.map((e) => e.toJson()).toList();
//     _data['history'] = history.map((e) => e.toJson()).toList();
//     return _data;
//   }
// }

// class Routine {
//   Routine({
//     this.id,
//     required this.exercise,
//     required this.name,
//   });
//   late final String? id;
//   late final List<Exercise> exercise;
//   late final String name;

//   Routine.fromJson(Map<String, dynamic> json) {
//     id = json['_id'];
//     exercise = json['exercise'];
//     name = json['name'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['_id'] = id;
//     _data['exercise'] = exercise;
//     _data['name'] = name;
//     return _data;
//   }
// }

// class Exercise {
//   Exercise({
//     required this.name,
//     required this.sets,
//     required this.reps,
//     this.id,
//   });
//   late final String name;
//   late final int sets;
//   late final int reps;
//   late final String? id;

//   Exercise.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     sets = json['sets'];
//     reps = json['reps'];
//     id = json['_id'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['name'] = name;
//     _data['sets'] = sets;
//     _data['reps'] = reps;
//     _data['_id'] = id;
//     return _data;
//   }
// }

// class Name {
//   Name({
//     required this.name,
//     required this.sets,
//     required this.reps,
//     required this.id,
//   });
//   late final String name;
//   late final int sets;
//   late final int reps;
//   late final String? id;

//   Name.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     sets = json['sets'];
//     reps = json['reps'];
//     id = json['_id'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['name'] = name;
//     _data['sets'] = sets;
//     _data['reps'] = reps;
//     _data['_id'] = id;
//     return _data;
//   }
// }

// class History {
//   History({
//     this.id,
//     required this.date,
//     required this.routine,
//     required this.log,
//   });
//   late final String? id;
//   late final String date;
//   late final String routine;
//   late final Log log;

//   History.fromJson(Map<String, dynamic> json) {
//     id = json['_id'];
//     date = json['date'];
//     routine = json['routine'];
//     log = Log.fromJson(json['log']);
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['_id'] = id;
//     _data['date'] = date;
//     _data['routine'] = routine;
//     _data['log'] = log.toJson();
//     return _data;
//   }
// }

// class Log {
//   Log({
//     required this.name,
//     required this.exercise,
//     this.id,
//   });
//   late final String name;
//   late final List<Exercise> exercise;
//   late final String? id;

//   Log.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     exercise =
//         List.from(json['exercise']).map((e) => Exercise.fromJson(e)).toList();
//     id = json['_id'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['name'] = name;
//     _data['exercise'] = exercise.map((e) => e.toJson()).toList();
//     _data['_id'] = id;
//     return _data;
//   }
// }
