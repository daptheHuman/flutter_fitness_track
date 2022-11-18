import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_fitness_track/model/routine_model.dart';

class ExerciseWidget extends StatefulWidget {
  ExerciseWidget(
      {Key? key,
      required this.index,
      required this.exerciseList,
      required this.updateExercise,
      required this.widgetList,
      required this.remove})
      : super(key: key);
  final List<ExerciseModel> exerciseList;
  final Function(ExerciseModel) updateExercise;
  final List<ExerciseWidget> widgetList;
  final Function(int) remove;
  final int index;

  @override
  State<ExerciseWidget> createState() => _ExerciseWidgetState();

  final _exerciseName = TextEditingController();
  final _exerciseSets = TextEditingController();
  final _exerciseReps = TextEditingController();
}

class _ExerciseWidgetState extends State<ExerciseWidget> {
  @override
  Widget build(BuildContext context) {
    @override
    void updateExercise() {
      ExerciseModel newExercise = ExerciseModel(
          name: widget._exerciseName.text,
          sets: int.parse(widget._exerciseSets.text),
          reps: int.parse(widget._exerciseReps.text));

      if (widget.exerciseList.length > widget.index) {
        return;
      }

      widget.updateExercise(newExercise);
    }

    void deleteExercise() {
      widget.remove(widget.index);
    }

    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  child: CustomField(
                    onEditingComplete: updateExercise,
                    type: TextInputType.name,
                    hintText: "Exercise Name",
                    controller: widget._exerciseName,
                  ),
                ),
                const VerticalDivider(),
                IconButton(
                    onPressed: () => deleteExercise(),
                    icon: const Icon(Icons.delete))
              ],
            ),
            const Divider(
              color: Colors.black,
              height: 40,
              indent: 20,
              endIndent: 20,
            ),
            CustomField(
              onEditingComplete: updateExercise,
              type: TextInputType.number,
              hintText: "Sets",
              controller: widget._exerciseSets,
            ),
            const Padding(
              padding: EdgeInsets.all(3),
            ),
            CustomField(
              onEditingComplete: updateExercise,
              type: TextInputType.number,
              hintText: "Reps",
              controller: widget._exerciseReps,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomField extends StatelessWidget {
  final TextInputType type;
  final String hintText;
  final TextEditingController controller;
  final VoidCallback onEditingComplete;
  const CustomField({
    Key? key,
    required this.type,
    required this.hintText,
    required this.controller,
    required this.onEditingComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onEditingComplete: () => {onEditingComplete()},
      keyboardType: type,
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(20),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white, fontSize: 15),
        filled: true,
        fillColor: Colors.grey[400],
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.grey, width: 2)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey.shade800, width: 2)),
      ),
    );
  }
}
