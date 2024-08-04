import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../models/task.dart';
import 'add_task_screen.dart';
import 'task_detail_screen.dart';

enum SortOptions { newestFirst, oldestFirst, alphabetical }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  SortOptions _currentSortOption = SortOptions.newestFirst;

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    List<Task> tasks = List.from(taskProvider.tasks);
    switch (_currentSortOption) {
      case SortOptions.newestFirst:
        tasks.sort((a, b) => b.date.compareTo(a.date));
        break;
      case SortOptions.oldestFirst:
        tasks.sort((a, b) => a.date.compareTo(b.date));
        break;
      case SortOptions.alphabetical:
        tasks.sort((a, b) => a.name.compareTo(b.name));
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('📌 Tempo Tasks'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: PopupMenuButton<SortOptions>(
              onSelected: (SortOptions selectedSort) {
                setState(() {
                  _currentSortOption = selectedSort;
                });
              },
              icon: const Icon(Icons.sort),
              itemBuilder: (BuildContext context) => <PopupMenuEntry<SortOptions>>[
                const PopupMenuItem<SortOptions>(
                  value: SortOptions.newestFirst,
                  child: Text('Newest First'),
                ),
                const PopupMenuItem<SortOptions>(
                  value: SortOptions.oldestFirst,
                  child: Text('Oldest First'),
                ),
                const PopupMenuItem<SortOptions>(
                  value: SortOptions.alphabetical,
                  child: Text('Alphabetical'),
                ),
              ],
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            title: Text(task.name),
            subtitle: Text('${task.category} - ${_formatDuration(task.expectedDuration)}'),
            trailing: Text(
              _formatDate(task.date),
              style: const TextStyle(color: Colors.grey),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TaskDetailScreen(task: task),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // Date format
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  // Duration format
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  }
}
