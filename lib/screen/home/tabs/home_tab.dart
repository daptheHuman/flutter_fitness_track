import 'dart:convert';

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fitness_track/model/history_model.dart';
import 'package:flutter_fitness_track/model/routine_model.dart';
import 'package:flutter_fitness_track/provider/auth_provider.dart';
import 'package:flutter_fitness_track/provider/history_provider.dart';
import 'package:flutter_fitness_track/provider/profile_provider.dart';
import 'package:flutter_fitness_track/screen/history/history_detail.dart';
import 'package:flutter_fitness_track/screen/home/tabs/history_tab.dart';
import 'package:flutter_fitness_track/screen/signin/signin.dart';
import 'package:flutter_fitness_track/widgets/routine_card.dart';
import 'package:flutter_fitness_track/widgets/vertical_padding.dart';
import 'package:provider/provider.dart';

class HomeTabs extends StatefulWidget {
  const HomeTabs({super.key});

  @override
  State<HomeTabs> createState() => _HomeTabsState();
}

class _HomeTabsState extends State<HomeTabs> {
  List<HistoryModel> todayHistory = [];
  Future<List<HistoryModel>> getTodayHistory(context, userId) async {
    todayHistory = await Provider.of<HistoryProvider>(context, listen: false)
        .todayHistory(userId);

    return todayHistory;
  }

  @override
  void initState() {
    super.initState();
    // getTodayHistory(context, userId);
  }

  @override
  Widget build(BuildContext context) {
    final String userId =
        Provider.of<ProfileProvider>(context, listen: false).userId;

    List<Widget> recentCards = [
      RoutineCard(
        routine: RoutineModel(name: "Arm", exercise: []),
      ),
      RoutineCard(
        routine: RoutineModel(name: "Arm", exercise: []),
      ),
    ];

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HomeBar(),
          // const DateTimeline(),
          // const RecommendedCard(),
          const Divider(
            height: 20,
          ),
          Text("Recent Activity",
              style: Theme.of(context).textTheme.titleLarge),
          const VerticalPadding(height: 10),
          Expanded(
            child: FutureBuilder<List<HistoryModel>>(
              future: getTodayHistory(context, userId),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.isEmpty) {
                    return Center(
                      child: Text("No History for today!",
                          style: Theme.of(context).textTheme.titleLarge),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return HistoryCard(
                        history: snapshot.data[index],
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          )
          // RoutineCollection(cardCollection: recentCards),
        ],
      ),
    );
  }
}

class DateTimeline extends StatelessWidget {
  const DateTimeline({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DatePicker(
      DateTime.now().subtract(Duration(days: 30)),
      initialSelectedDate: DateTime.now(),
      height: 100,
      width: 75,
      selectionColor: Theme.of(context).colorScheme.secondary,
    );
  }
}

class RoutineCollection extends StatelessWidget {
  const RoutineCollection(
      {Key? key, required this.cardCollection, required this.history})
      : super(key: key);

  final List<Widget> cardCollection;
  final List<HistoryModel> history;

  @override
  Widget build(BuildContext context) {
    return Expanded(child: ListView(children: [...cardCollection]));
  }
}

class RecommendedCard extends StatelessWidget {
  const RecommendedCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Recommended",
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.w500),
              ),
              Text(
                "Full Body",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const VerticalPadding(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Level Hard",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    "No Equipment",
                    style: Theme.of(context).textTheme.titleSmall,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class HomeBar extends StatefulWidget {
  const HomeBar({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeBar> createState() => _HomeBarState();
}

class _HomeBarState extends State<HomeBar> {
  @override
  Widget build(BuildContext context) {
    void signOut() async {
      await Provider.of<AuthProvider>(context, listen: false).signout();

      if (mounted) return;
      Provider.of<ProfileProvider>(context, listen: false).clearProfile();
    }

    String username =
        Provider.of<ProfileProvider>(context, listen: true).username;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hello",
                style: TextStyle(
                    color: Colors.black,
                    fontSize:
                        Theme.of(context).textTheme.headlineSmall?.fontSize)),
            Text("$username!",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight:
                        Theme.of(context).textTheme.headlineLarge?.fontWeight,
                    fontSize:
                        Theme.of(context).textTheme.headlineMedium?.fontSize)),
          ],
        ),
        InkWell(
          onTap: () => signOut(),
          child: const Icon(Icons.logout),
        ),
      ],
    );
  }
}
