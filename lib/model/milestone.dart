import 'package:achiever_app/model/task.dart';

class Milestone {
  bool isDone;
  DateTime dateCompleted;
  DateTime dueDate;
  String title;
  String description;
  List<Task> tasksTodo;
  List<Task> tasksDone;

  Milestone({
    this.isDone,
    this.dateCompleted,
    this.dueDate,
    this.title,
    this.description,
  });
}
