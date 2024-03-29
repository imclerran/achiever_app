import 'package:achiever_app/model/task.dart';

class Milestone {
  bool isDone;
  DateTime dateCompleted;
  DateTime dueDate;
  String title;
  String description;
  List<Task>? tasksTodo;
  List<Task>? tasksDone;

  Milestone({
    required this.isDone,
    required this.dateCompleted,
    required this.dueDate,
    required this.title,
    required this.description,
  });
}
