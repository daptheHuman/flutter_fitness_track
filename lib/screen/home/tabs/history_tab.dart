import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_fitness_track/model/history_model.dart';
import 'package:flutter_fitness_track/provider/history_provider.dart';
import 'package:flutter_fitness_track/provider/profile_provider.dart';
import 'package:flutter_fitness_track/screen/history/history_detail.dart';
import 'package:flutter_fitness_track/services/history_service.dart';
import 'package:flutter_fitness_track/utils/duration.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class HistoryTab extends StatefulWidget {
  const HistoryTab({super.key});

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  List<HistoryModel> historyList = List.empty(growable: true);

  void getHistoryList() async {
    String userId = Provider.of<ProfileProvider>(context, listen: false).userId;
    List<HistoryModel> history =
        await HistoryService().getAllHistory(userId: userId);

    if (!mounted) return;
    Provider.of<HistoryProvider>(context, listen: false).setHistory = history;
  }

  @override
  void initState() {
    super.initState();
    getHistoryList();
    historyList = Provider.of<HistoryProvider>(context, listen: false)
        .historyOnDate(_selectedDay);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
            firstDay: DateTime.now().subtract(const Duration(days: 30 * 12)),
            lastDay: DateTime.now().add(const Duration(days: 30 * 12)),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              // if (!isSameDay(selectedDay, focusedDay)) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                historyList =
                    Provider.of<HistoryProvider>(context, listen: false)
                        .historyOnDate(
                            _selectedDay); // update `_focusedDay` here as well
              });
            },
            eventLoader: (day) {
              // print(day);
              return Provider.of<HistoryProvider>(context, listen: true)
                  .historyOnDate(day);
            }),
        const Divider(
          height: 20,
          indent: 10,
          endIndent: 10,
          thickness: 2,
        ),
        Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: historyList.length,
              itemBuilder: (context, index) {
                return historyList.isNotEmpty
                    ? HistoryCard(history: historyList[index])
                    : const Text("There is no data!");
              }),
          // child: FutureBuilder<List<HistoryModel>>(
          //   builder: (context, snapshot) {
          //     if (snapshot.hasData) {
          //       return ListView.builder(
          //           shrinkWrap: true,
          //           itemCount: snapshot.data!.length,
          //           itemBuilder: (context, index) {
          //             return snapshot.data!.isNotEmpty
          //                 ? HistoryCard(history: snapshot.data![index])
          //                 : const Text("There is no data!");
          //           });
          //     }
          //     if (snapshot.hasError) {
          //       return const Text("There is no data!");
          //     } else {
          //       return const Center(child: CircularProgressIndicator());
          //     }
          //   },
          // ),
        )
      ],
    );
  }
}

class HistoryCard extends StatelessWidget {
  final HistoryModel history;
  const HistoryCard({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    DateTime startTime = DateTime.parse(history.startDate);
    DateTime endTime = DateTime.parse(history.endDate);

    void navigateToHistoryDetail() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HistoryDetail(history: history)));
    }

    return InkWell(
      onTap: () => navigateToHistoryDetail(),
      child: Card(
        child: Column(children: [
          ListTile(
            title: Text(
                "${startTime.day.toString()}/${startTime.month} ${startTime.year}"),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                    "Start: ${startTime.hour}:${startTime.minute} End: ${endTime.hour}:${endTime.minute}"),
                Text("Duration: ${printDuration(startTime, endTime)}")
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
