//22k-4156,22k-4574, 22k-4431,22k-4494
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:persistent_todo/todo_logic.dart';
import 'dart:convert';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Tasks',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2196F3),
        ).copyWith(
          inversePrimary: const Color(0xFFBBDEFB),
        ),
        useMaterial3: true,
      ),
      home: const TodoListPage(),
    );
  }
}

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});
  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List<Map<String, dynamic>> _todoItems = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? tasksJson = prefs.getString('tasks');
    if (tasksJson != null) {
      final List decoded = jsonDecode(tasksJson);
      setState(() {
        _todoItems = decoded.map((e) => Map<String, dynamic>.from(e)).toList();
      });
    } else {
      setState(() {
        _todoItems = [
          {'title': 'Buy groceries', 'isDone': false},
          {'title': 'Finish Flutter project', 'isDone': true},
          {'title': 'Go for a run', 'isDone': false},
        ];
      });
      _saveTasks();
    }
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('tasks', jsonEncode(_todoItems));
  }

  void _markAllDone() {
    setState(() {
      _todoItems = markAllDone(_todoItems);
    });
    _saveTasks();
  }

  void _sortTasks() {
    setState(() {
      _todoItems = sortTasks(_todoItems);
    });
    _saveTasks();
  }

  void _showAddTaskDialog() {
    final TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Task'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Enter task title'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final title = controller.text.trim();
              if (title.isNotEmpty) {
                setState(() {
                  _todoItems.add({'title': title, 'isDone': false});
                });
                _saveTasks();
              }
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      appBar: AppBar(
        title: const Text('My Tasks'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: _sortTasks,
            tooltip: 'Sort tasks',
          ),
          IconButton(
            icon: const Icon(Icons.done_all),
            onPressed: _markAllDone,
            tooltip: 'Mark all done',
          ),
        ],
      ),
      body: Container(
        color: Theme.of(context).colorScheme.inversePrimary,
        child: ListView.builder(
          itemCount: _todoItems.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: ListTile(
                title: Text(
                  _todoItems[index]['title'],
                  style: TextStyle(
                    decoration: _todoItems[index]['isDone']
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
                trailing: Checkbox(
                  value: _todoItems[index]['isDone'],
                  onChanged: (bool? value) {
                    setState(() {
                      _todoItems[index]['isDone'] = value!;
                    });
                    _saveTasks();
                  },
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}