String printDuration(DateTime start, DateTime end) {
  Duration difference = end.difference(start);
  return "${difference.inMinutes.remainder(60).toString().padLeft(2, '0')}:${difference.inSeconds.remainder(60).toString().padLeft(2, '0')}";
}
