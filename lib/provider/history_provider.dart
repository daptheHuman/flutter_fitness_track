import 'dart:convert';
import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter_fitness_track/model/history_model.dart';
import 'package:flutter_fitness_track/services/history_service.dart';
import 'package:table_calendar/table_calendar.dart';

class HistoryProvider extends ChangeNotifier {
  List<HistoryModel> _histories = List.empty(growable: true);

  List<HistoryModel> get allHistory => _histories.toList();
  Future<List<HistoryModel>> todayHistory(userid) async {
    _histories = await HistoryService().getAllHistory(userId: userid);
    List<HistoryModel> histories = _histories
        .where((element) =>
            isSameDay(DateTime.parse(element.startDate), DateTime.now()))
        .toList();

    return histories;
  }

  set setHistory(List<HistoryModel> histories) {
    _histories = histories;
    notifyListeners();
  }

  List<HistoryModel> historyOnDate(DateTime date) {
    List<HistoryModel> histories = _histories
        .where((element) => isSameDay(DateTime.parse(element.startDate), date))
        .toList();

    return histories;
  }
}
