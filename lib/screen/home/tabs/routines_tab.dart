import 'package:flutter/material.dart';
import 'package:flutter_fitness_track/provider/discover_routines_provider.dart';
import 'package:flutter_fitness_track/provider/user_routines_provider.dart';
import 'package:flutter_fitness_track/services/routine_service.dart';
import 'package:flutter_fitness_track/widgets/routine_card.dart';
import 'package:flutter_fitness_track/widgets/vertical_padding.dart';
import 'package:provider/provider.dart';

import '../../../model/routine_model.dart';
import '../../routine/add_routine.dart';

class RoutinesTabs extends StatefulWidget {
  const RoutinesTabs({super.key});

  @override
  State<RoutinesTabs> createState() => _RoutinesTabsState();
}

class _RoutinesTabsState extends State<RoutinesTabs> {
  // void getAllRoutines() async {
  //   List<RoutineModel> routines = await RoutineService().getAllRoutine();
  //   List<RoutineCard> newRoutines = [];
  //   routines.map((e) => newRoutines.add(RoutineCard(routine: e))).toList();
  //   if (!mounted) return;
  //   context.read<UserRoutinesProvider>().setCollection = newRoutines;
  // }

  @override
  void initState() {
    super.initState();

    // getAllRoutines();
  }

  @override
  Widget build(BuildContext context) {
    final routineCardCollection =
        context.watch<UserRoutinesProvider>().routines;
    final discoverCardCollection =
        context.read<DiscoverRoutinesProvider>().routines;

    return Scaffold(
      floatingActionButton: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Theme.of(context).colorScheme.secondary),
        child: TextButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddRoutineScreen())),
            child: Text(
              "Add New Routines",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            )),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                height: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Discover",
                        style: Theme.of(context).textTheme.headlineSmall),
                    Expanded(
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [...discoverCardCollection],
                      ),
                    ),
                  ],
                )),
            const VerticalPadding(height: 20),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("My Routines",
                    style: Theme.of(context).textTheme.headlineSmall),
                Expanded(
                  child: FutureBuilder<List<RoutineModel>>(
                    future: RoutineService().getAllRoutine(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        List<RoutineModel> routines = snapshot.data;
                        if (routines.isEmpty) {
                          return const Center(
                              child: Text("You doesnt have any routine"));
                        }
                        List<RoutineCard> routinesCard = [];
                        routines
                            .map((e) =>
                                routinesCard.add(RoutineCard(routine: e)))
                            .toList();
                        return ListView(
                          children: [...routinesCard],
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                )
              ],
            )),
          ],
        ),
      ),
    );
  }
}

class DiscoverCard extends StatelessWidget {
  final String title;
  final String imageAssets;

  const DiscoverCard({
    super.key,
    required this.title,
    required this.imageAssets,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      color: Theme.of(context).colorScheme.surface,
      child: SizedBox(
        width: 200,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Stack(
            children: [
              Positioned(
                  right: 0,
                  top: 25,
                  child: Image(
                    image: AssetImage(imageAssets),
                    height: 170,
                    width: 120,
                    alignment: Alignment.topCenter,
                    fit: BoxFit.cover,
                  )),
              SizedBox(
                width: 200,
                child: Text(
                  title,
                  style: TextStyle(
                      color: (Colors.white),
                      fontWeight: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.fontWeight,
                      fontSize:
                          Theme.of(context).textTheme.headlineMedium?.fontSize),
                ),
              ),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Theme.of(context).colorScheme.secondary),
                    child: TextButton(
                        onPressed: () => {},
                        child: Text(
                          "Start",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface),
                        )),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
