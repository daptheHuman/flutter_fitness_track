import 'dart:async';
import 'package:flutter_fitness_track/model/history_model.dart';
import 'package:flutter_fitness_track/provider/profile_provider.dart';
import 'package:flutter_fitness_track/services/history_service.dart';
import 'package:flutter_fitness_track/utils/duration.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fitness_track/model/routine_model.dart';
import 'package:provider/provider.dart';

class StartRoutine extends StatefulWidget {
  final RoutineModel routine;
  final HistoryModel? routineHistory;

  const StartRoutine({super.key, required this.routine, this.routineHistory});

  @override
  State<StartRoutine> createState() => _StartRoutineState();
}

class _StartRoutineState extends State<StartRoutine> {
  DateTime startTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    List<ExerciseModel> editedExercise = List.from(widget.routine.exercise);

    void updateExercise(
      List<ExerciseModel> listExercise,
    ) {
      editedExercise = listExercise;
    }

    void onDone() async {
      HistoryModel newHistory = HistoryModel(
          userId: Provider.of<ProfileProvider>(context, listen: false).userId,
          routineId: widget.routine.id.toString(),
          startDate: startTime.toIso8601String(),
          endDate: DateTime.now().toIso8601String(),
          routine: editedExercise);

      String res = await HistoryService().addHistory(newHistory: newHistory);

      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(res),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                )
              ],
            );
          });
    }

    return Scaffold(
      floatingActionButton: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ))),
          onPressed: () => onDone(),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Done"),
          )),
      appBar: AppBar(
        title: Text(widget.routine.name),
        actions: [TimerWidget(startTime: startTime)],
      ),
      body: Column(
        children: [
          Text("Start Time: ${DateFormat('HH:mm').format(startTime)}"),
          Expanded(
            child: ListView.builder(
              itemCount: editedExercise.length,
              itemBuilder: (context, index) {
                return ExerciseWidget(
                  exerciseList: editedExercise,
                  index: index,
                  updateExercise: updateExercise,
                  exerciseHistory: widget.routineHistory,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TimerWidget extends StatefulWidget {
  final DateTime startTime;
  const TimerWidget({super.key, required this.startTime});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  @override
  Widget build(BuildContext context) {
    DateTime currentTime = DateTime.now();

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          currentTime = DateTime.now();
        });
      }
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(printDuration(widget.startTime, currentTime)),
        )
      ],
    );
  }
}

class ExerciseWidget extends StatefulWidget {
  final List<ExerciseModel> exerciseList;
  final int index;
  final Function(List<ExerciseModel>) updateExercise;
  final HistoryModel? exerciseHistory;

  const ExerciseWidget({
    super.key,
    required this.exerciseList,
    required this.index,
    required this.updateExercise,
    this.exerciseHistory,
  });

  @override
  State<ExerciseWidget> createState() => _ExerciseWidgetState();
}

class _ExerciseWidgetState extends State<ExerciseWidget> {
  final TextEditingController _setsController = TextEditingController();
  final TextEditingController _repsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final List<ExerciseModel> updatedExercise = List.from(widget.exerciseList);

    void updateExercise() {
      updatedExercise[widget.index] = ExerciseModel(
          id: updatedExercise[widget.index].id,
          name: updatedExercise[widget.index].name,
          sets: int.parse(_setsController.text),
          reps: int.parse(_repsController.text));
      widget.updateExercise(updatedExercise);
    }

    int routineReps = widget.exerciseHistory?.routine[widget.index].reps ??
        widget.exerciseList[widget.index].reps;
    int routineSets = widget.exerciseHistory?.routine[widget.index].sets ??
        widget.exerciseList[widget.index].sets;

    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.exerciseList[widget.index].name,
              style: const TextStyle(fontSize: 20)),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _setsController,
                  keyboardType: TextInputType.number,
                  onEditingComplete: () => updateExercise(),
                  decoration: InputDecoration(
                    hintText: routineSets.toString(),
                    helperText: 'sets',
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: _repsController,
                  keyboardType: TextInputType.number,
                  onEditingComplete: () => updateExercise(),
                  decoration: InputDecoration(
                      hintText: routineReps.toString(), helperText: 'reps'),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
