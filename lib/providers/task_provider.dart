import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  final List<Task> _tasks = [
    // Test
    Task(
      name: 'Faire du sport',
      category: 'Sport',
      comment: 'A faire le matin',
      duration: const Duration(hours: 1),
      date: DateTime.now(),
    ),
  ];

  List<Task> get tasks => _tasks;
}