import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_fitness_track/model/history_model.dart';

class HistoryDetail extends StatelessWidget {
  final HistoryModel history;
  const HistoryDetail({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.parse(history.startDate);

    return Scaffold(
      appBar: AppBar(
        title: Text('${date.day}/${date.month}/${date.year}'),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: history.routine.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(history.routine[index].name),
                subtitle: Text(
                    '${history.routine[index].reps} reps x ${history.routine[index].sets} sets'),
              );
            }),
      ),
    );
  }
}
