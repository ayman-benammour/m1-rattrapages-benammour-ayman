class Task {
  String name;
  String category;
  String comment;
  Duration expectedDuration;
  DateTime date;
  Duration duration;
  bool isRunning;
  bool isCompleted = false;
  DateTime? startTime;

  Task({
    required this.name,
    required this.category,
    required this.comment,
    required this.expectedDuration,
    required this.date,
    this.duration = Duration.zero,
    this.isRunning = false,
    this.startTime,
  });
}
