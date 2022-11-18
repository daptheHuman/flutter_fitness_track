import 'package:flutter/cupertino.dart';
import '../model/routine_model.dart';
import '../widgets/routine_card.dart';

class UserRoutinesProvider extends ChangeNotifier {
  List<RoutineCard> _routinesCollection = [
    // RoutineCard(
    //   routine: RoutineModel(id: "0", name: "Arm", exercise: []),
    // ),
    // RoutineCard(
    //   routine: RoutineModel(id: "0", name: "Leg", exercise: []),
    // ),
    // RoutineCard(
    //   routine: RoutineModel(id: "0", name: "Arm", exercise: []),
    // ),
  ];

  List<RoutineCard> get routines => _routinesCollection;

  set setCollection(List<RoutineCard> routineList) {
    _routinesCollection = routineList;

    notifyListeners();
  }

  void addRoutines(RoutineModel routine) {
    RoutineCard newRoutine = RoutineCard(routine: routine);
    _routinesCollection.add(newRoutine);

    notifyListeners();
  }
}
