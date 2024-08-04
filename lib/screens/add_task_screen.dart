import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../models/task.dart';

class AddTaskScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _commentController = TextEditingController();
  final _expectedDurationController = TextEditingController();

  AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('➕ Add a task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Task name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a task name';
                  }
                  return null;
                },
              ),
              // Pour l'instant text mais mettre list
              TextFormField(
                controller: _categoryController,
                decoration: const InputDecoration(labelText: 'Category'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a category';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _commentController,
                decoration: const InputDecoration(labelText: 'Comment'),
              ),
              TextFormField(
                controller: _expectedDurationController,
                decoration: const InputDecoration(labelText: 'Expected Duration (in minutes)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the expected duration';
                  }
                  if (int.tryParse(value) == null || int.parse(value) <= 0) {
                    return 'Please enter a valid duration';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final expectedDuration = Duration(minutes: int.parse(_expectedDurationController.text));
                    final task = Task(
                      name: _nameController.text,
                      category: _categoryController.text,
                      comment: _commentController.text,
                      expectedDuration: expectedDuration,
                      duration: Duration.zero,
                      date: DateTime.now(),
                    );
                    Provider.of<TaskProvider>(context, listen: false).addTask(task);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Add task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}