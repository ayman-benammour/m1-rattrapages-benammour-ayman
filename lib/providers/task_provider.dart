import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskProvider with ChangeNotifier {

  // List tasks
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

  // Add task
  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  // Edit task
  void updateTask(Task task, String name, String category, String comment) {
    task.name = name;
    task.category = category;
    task.comment = comment;
    notifyListeners();
  }

  // Remove task
  // a faire
}