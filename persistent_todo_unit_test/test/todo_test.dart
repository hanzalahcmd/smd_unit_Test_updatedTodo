import 'package:flutter_test/flutter_test.dart';
import 'package:persistent_todo/todo_logic.dart';

void main() {
  test('markAllDone marks every task as done', () {
    final tasks = [
      {'title': 'Buy groceries', 'isDone': false},
      {'title': 'Go for a run', 'isDone': false},
      {'title': 'Finish project', 'isDone': true},
    ];

    final result = markAllDone(tasks);

    expect(result.every((task) => task['isDone'] == true), true);
  });

  test('sortTasks puts incomplete tasks before completed tasks', () {
    final tasks = [
      {'title': 'Done task', 'isDone': true},
      {'title': 'Pending task', 'isDone': false},
      {'title': 'Another done', 'isDone': true},
      {'title': 'Another pending', 'isDone': false},
    ];

    final result = sortTasks(tasks);

    expect(result[0]['isDone'], false);
    expect(result[1]['isDone'], false);
    expect(result[2]['isDone'], true);
    expect(result[3]['isDone'], true);
  });

  test('markAllDone does not modify the original list', () {
    final tasks = [
      {'title': 'Buy groceries', 'isDone': false},
      {'title': 'Go for a run', 'isDone': false},
    ];

    final result = markAllDone(tasks);

    expect(tasks[0]['isDone'], false);
    expect(result[0]['isDone'], true);
  });
}
