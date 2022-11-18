import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_fitness_track/model/routine_model.dart';
import 'package:flutter_fitness_track/model/token_model.dart';
import 'package:flutter_fitness_track/screen/home/home_screen.dart';
import 'package:flutter_fitness_track/screen/home/tabs/home_tab.dart';
import 'package:flutter_fitness_track/screen/routine/widget/exercise_widget.dart';
import 'package:flutter_fitness_track/services/routine_service.dart';

class AddRoutineScreen extends StatefulWidget {
  const AddRoutineScreen({super.key});

  @override
  State<AddRoutineScreen> createState() => _AddRoutineScreenState();
}

class _AddRoutineScreenState extends State<AddRoutineScreen> {
  final _name = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Add new Exercise
  void addExercise(
    ExerciseModel newExercise,
  ) {
    _exerciseList.add(newExercise);
  }

// Add new Form
  void addForm() {
    setState(() {
      _exerciseWidgetList.add(ExerciseWidget(
        index: _exerciseWidgetList.length,
        exerciseList: _exerciseList,
        updateExercise: addExercise,
        widgetList: _exerciseWidgetList,
        remove: deleteForm,
      ));
    });
  }

  // Delete Form
  void deleteForm(int index) {
    setState(() {
      _exerciseWidgetList.removeAt(index);
      if (_exerciseList.isNotEmpty) _exerciseList.removeAt(index);
    });
  }

  // Validate Form
  String? validateForm(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  // Save Routine
  void saveRoutine() async {
    if (_formKey.currentState!.validate()) {
      RoutineModel newRoutine = RoutineModel(
        name: _name.text,
        exercise: _exerciseList,
      );

      await RoutineService().addNewRoutine(newRoutine);

      if (!mounted) return;
      Navigator.pop(context);
    }
  }

  final List<ExerciseModel> _exerciseList = [];
  final List<ExerciseWidget> _exerciseWidgetList = [];

  @override
  Widget build(BuildContext context) {
    var nameField = TextFormField(
      validator: (value) => validateForm(value),
      controller: _name,
      style: const TextStyle(fontSize: 15, color: Colors.black),
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400, width: 2),
          ),
          hintText: "Routine Name",
          hintStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          )),
    );

    return Scaffold(
        appBar: AppBar(actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                saveRoutine();
              },
            ),
          )
        ]),
        floatingActionButton: FloatingActionButton.extended(
          elevation: 10,
          onPressed: () => addForm(),
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          label: const Text(
            "Add Exercise",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "New Routine",
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                nameField,
                const VerticalDivider(indent: 30),
                Text(
                  "Exercise List",
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: _exerciseWidgetList.length,
                      itemBuilder: (BuildContext context, index) {
                        return _exerciseWidgetList[index];
                      }),
                ),
              ],
            ),
          ),
        ));
  }
}
