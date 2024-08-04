import 'package:flutter/material.dart';
import '../models/task.dart';
import 'dart:async';

class TaskProvider with ChangeNotifier {
  final List<Task> _tasks = [];
  Timer? _timer;

  List<Task> get tasks => _tasks;

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void editTask(Task task, String name, String category, String comment) {
    task.name = name;
    task.category = category;
    task.comment = comment;
    notifyListeners();
  }

  void deleteTask(BuildContext context, Task task) {
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

  void startTimer(Task task) {
    task.isRunning = true;
    task.startTime = DateTime.now();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (task.isRunning) {
        task.duration += const Duration(seconds: 1);
        if (task.duration >= task.expectedDuration && !task.isCompleted) {
          task.isCompleted = true;
        }
        notifyListeners();
      }
    });
  }

  void stopTimer(BuildContext context, Task task) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm stop'),
          content: const Text('If you stop the timer, you won\'t be able to restart it. Are you sure?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                task.isRunning = false;
                if (task.duration < task.expectedDuration) {
                  task.isCompleted = true;
                }
                _timer?.cancel();
                _timer = null;
                notifyListeners();
                Navigator.of(context).pop();
              },
              child: const Text('Stop'),
            ),
          ],
        );
      },
    );
  }
}
