import 'package:flutter/material.dart';
import 'package:flutter_fitness_track/model/routine_model.dart';
import 'package:flutter_fitness_track/screen/routine/view_routine.dart';

class RoutineCard extends StatelessWidget {
  final RoutineModel routine;

  const RoutineCard({
    Key? key,
    required this.routine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.white,
      onTap: () => {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewRoutine(routine: routine)))
      },
      child: Card(
        elevation: 0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        color: Theme.of(context).colorScheme.primary,
        child: ListTile(
          leading: const CircleAvatar(child: Icon(Icons.fitness_center)),
          title: Text(routine.name,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white)),
        ),
      ),
    );
  }
}
