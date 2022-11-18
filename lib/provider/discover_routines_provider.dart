import 'package:flutter_fitness_track/screen/home/tabs/routines_tab.dart';

class DiscoverRoutinesProvider {
  final List<DiscoverCard> _routinesCollection = [
    const DiscoverCard(
        title: "Cardio", imageAssets: "assets/images/running.png"),
    const DiscoverCard(
        title: "Bodyweight", imageAssets: "assets/images/calisthenic.png"),
    const DiscoverCard(title: "Weight", imageAssets: "assets/images/gym.png"),
  ];

  List<DiscoverCard> get routines => _routinesCollection;
}
