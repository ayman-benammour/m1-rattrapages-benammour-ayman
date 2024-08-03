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

  // Delete task
  void removeTask(BuildContext context, Task task) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('🗑️ Confirm deletion'),
          content: const Text('Are you sure you want to delete this task?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                  _tasks.remove(task);
                  notifyListeners();
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

}