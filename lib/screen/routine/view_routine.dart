import 'package:flutter/material.dart';
import 'package:flutter_fitness_track/model/history_model.dart';
import 'package:flutter_fitness_track/model/routine_model.dart';
import 'package:flutter_fitness_track/provider/profile_provider.dart';
import 'package:flutter_fitness_track/screen/routine/start_routine.dart';
import 'package:flutter_fitness_track/services/history_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ViewRoutine extends StatefulWidget {
  final RoutineModel routine;
  const ViewRoutine({super.key, required this.routine});

  @override
  State<ViewRoutine> createState() => _ViewRoutineState();
}

class _ViewRoutineState extends State<ViewRoutine> {
  List<HistoryModel> routineHistory = [];

  void getRoutineHistory(String userId) async {
    routineHistory = await HistoryService().getHistroyRoutine(
        routineId: widget.routine.id.toString(), userId: userId);
  }

  void navigateToStartRoutine() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => StartRoutine(
                  routine: widget.routine,
                  routineHistory:
                      routineHistory.isNotEmpty ? routineHistory.last : null,
                )));
  }

  @override
  Widget build(BuildContext context) {
    String userId = Provider.of<ProfileProvider>(context).userId;
    getRoutineHistory(userId);

    Provider.of<ProfileProvider>(context, listen: false).userId;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.routine.name),
      ),
      floatingActionButton: ElevatedButton(
          onPressed: () => widget.routine.exercise.isNotEmpty
              ? navigateToStartRoutine()
              : Fluttertoast.showToast(
                  msg: "No such exercise",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0),
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text("Start"),
          )),
      body: Column(
        children: [
          Expanded(
            child: widget.routine.exercise.isNotEmpty
                ? ListView.builder(
                    itemCount: widget.routine.exercise.length,
                    itemBuilder: (context, index) {
                      return _ExerciseCard(
                          exercise: widget.routine.exercise[index]);
                    })
                : Column(
                    children: [
                      Image.asset("assets/images/cry.png"),
                      Text("No such exercise",
                          style: Theme.of(context).textTheme.headlineMedium),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

class _ExerciseCard extends StatefulWidget {
  final ExerciseModel exercise;
  const _ExerciseCard({required this.exercise});

  @override
  State<_ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<_ExerciseCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        title: Text(widget.exercise.name),
        subtitle: SizedBox(
          height: 15,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Sets: ${widget.exercise.sets.toString()}"),
              const VerticalDivider(
                width: 15,
                thickness: 1.5,
                indent: 2,
                color: Colors.grey,
              ),
              Text("Reps: ${widget.exercise.reps.toString()}"),
            ],
          ),
        ),
      ),
    );
  }
}
