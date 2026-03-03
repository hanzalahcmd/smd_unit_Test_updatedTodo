List<Map<String, dynamic>> markAllDone(List<Map<String, dynamic>> tasks) {
  return tasks.map((task) => {...task, 'isDone': true}).toList();
}

List<Map<String, dynamic>> sortTasks(List<Map<String, dynamic>> tasks) {
  final sorted = List<Map<String, dynamic>>.from(tasks);
  sorted.sort((a, b) {
    if (a['isDone'] == b['isDone']) return 0;
    return a['isDone'] ? 1 : -1;
  });
  return sorted;
}