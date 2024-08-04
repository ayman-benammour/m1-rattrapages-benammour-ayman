import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';
import 'edit_task_screen.dart';

class TaskDetailScreen extends StatelessWidget {
  final Task task;

  const TaskDetailScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(task.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditTaskScreen(task: task),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                taskProvider.deleteTask(context, task);
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('${task.category} category', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text(task.comment, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            Row(
              children: [
                Consumer<TaskProvider>(
                  builder: (context, taskProvider, child) {
                    return Text(
                      'Time: ${_formatDuration(task.duration)}',
                      style: const TextStyle(fontSize: 30),
                    );
                  },
                ),
                const SizedBox(width: 8),
                Text(
                  '/ ${_formatDuration(task.expectedDuration)}',
                  style: const TextStyle(fontSize: 24, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if ((task.isRunning || task.duration > Duration.zero) && !task.isCompleted && task.duration < task.expectedDuration)
              const Text(
                'Duration not yet exceeded',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            if (task.isCompleted && task.duration < task.expectedDuration)
              const Text(
                'Duration not exceeded',
                style: TextStyle(fontSize: 24, color: Colors.red),
              ),
            if (task.isCompleted && task.duration >= task.expectedDuration)
              const Text(
                'Task Completed',
                style: TextStyle(fontSize: 24, color: Colors.green),
              ),
            const SizedBox(height: 20),
            Row(
              children: [
                if (!task.isRunning && task.duration == Duration.zero)
                  ElevatedButton(
                    onPressed: () {
                      taskProvider.startTimer(task);
                    },
                    child: const Text('Start'),
                  )
                else if (task.isRunning)
                  ElevatedButton(
                    onPressed: () {
                      taskProvider.stopTimer(context, task);
                    },
                    child: const Text('Stop'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  }
}
