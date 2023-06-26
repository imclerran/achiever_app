import 'package:achiever_app/constants/enums.dart';
import 'package:achiever_app/model/subtask.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'task.g.dart';

@immutable
@JsonSerializable()
class Task extends Equatable {
  final String id;
  final bool isDone;
  final DateTime? dateCompleted;
  final DateTime? dueDate;
  final String title;
  final String description;
  final List<Subtask> subtasks;
  final TaskPriority priority;

  Task({
    String? id,
    this.isDone = false,
    this.dateCompleted,
    this.dueDate,
    this.title = "",
    this.description = "",
    this.priority = TaskPriority.none,
    this.subtasks = const [],
  }) : this.id = id ?? Uuid().v4();

  int compareByDueDate(Task other) {
    if (null == this.dueDate) {
      if (null == other.dueDate) {
        // both due dates are null - use priority instead.
        return this.priority.index.compareTo(other.priority.index);
      }
      return -1; // this (dueDate) is null, other is not
    } else {
      if (null == other.dueDate) {
        return 1; // this (dueDate) is not null, other is
      } else {
        return this
            .dueDate!
            .compareTo(other.dueDate!); // neither dueDate is null
      }
    }
  }

  bool get isOverDue {
    if (null == dueDate) return false;
    var today = DateTime.now();
    today = DateTime(today.year, today.month, today.day, 0, 0, 0);
    return dueDate!.isBefore(today);
  }

  bool get isDueToday {
    if (dueDate == null) return false;
    var today = DateTime.now();
    if (dueDate!.year == today.year &&
        dueDate!.month == today.month &&
        dueDate!.day == today.day) return true;
    return false;
  }

  bool get isDueTomorrow {
    if (dueDate == null) return false;
    var tomorrow = DateTime.now().add(Duration(days: 1));
    if (dueDate!.year == tomorrow.year &&
        dueDate!.month == tomorrow.month &&
        dueDate!.day == tomorrow.day) return true;
    return false;
  }

  bool get isDueThisWeek {
    if (dueDate == null) return false;
    var today = DateTime.now();
    int daysToNextWeek = 8 - today.weekday;
    var firstOfNextWeek = today.add(Duration(days: daysToNextWeek));
    firstOfNextWeek = DateTime(
      firstOfNextWeek.year,
      firstOfNextWeek.month,
      firstOfNextWeek.day,
    );
    return dueDate!.isBefore(firstOfNextWeek);
  }

  bool get isDueThisWeekOrUndated {
    // Weekdays:
    // 1=mon,2=tue,3=wed,4=thu,5=fri,6=sat,7=sun
    if (dueDate == null) return true;
    var today = DateTime.now();
    int daysToNextWeek = 8 - today.weekday;
    var firstOfNextWeek = today.add(Duration(days: daysToNextWeek));
    firstOfNextWeek = DateTime(
      firstOfNextWeek.year,
      firstOfNextWeek.month,
      firstOfNextWeek.day,
    );
    return dueDate!.isBefore(firstOfNextWeek);
  }

  bool get isDueAfterThisWeek {
    if (dueDate == null) return false;
    var today = DateTime.now();
    int daysToLastWeekday = 7 - today.weekday;
    var lastDayOfWeek = today.add(Duration(days: daysToLastWeekday));
    lastDayOfWeek = DateTime(lastDayOfWeek.year, lastDayOfWeek.month,
        lastDayOfWeek.day, 23, 59, 59, 999);
    return dueDate!.isAfter(lastDayOfWeek);
  }

  bool get isDueAfterThisWeekOrUndated {
    if (dueDate == null) return true;
    var today = DateTime.now();
    int daysToLastWeekday = 7 - today.weekday;
    var lastDayOfWeek = today.add(Duration(days: daysToLastWeekday));
    lastDayOfWeek = DateTime(lastDayOfWeek.year, lastDayOfWeek.month,
        lastDayOfWeek.day, 23, 59, 59, 999);
    return dueDate!.isAfter(lastDayOfWeek);
  }

  String get dueDateString {
    if (null == dueDate) {
      return "Not set";
    } else {
      if (isDueToday) return "Today";
      if (isDueTomorrow) return "Tomorrow";
      var today = DateTime.now();
      today = DateTime(today.year, today.month, today.day, 0, 0, 0);
      if (dueDate!.isAfter(today) &&
          dueDate!.isBefore(today.add(Duration(days: 7)))) {
        if (1 == dueDate!.weekday) return "Monday";
        if (2 == dueDate!.weekday) return "Tuesday";
        if (3 == dueDate!.weekday) return "Wednesday";
        if (4 == dueDate!.weekday) return "Thursday";
        if (5 == dueDate!.weekday) return "Friday";
        if (6 == dueDate!.weekday) return "Saturday";
        if (7 == dueDate!.weekday) return "Sunday";
      }
      return "${dueDate!.month}/${dueDate!.day}/${dueDate!.year}";
    }
  }

  String get priorityString {
    if (TaskPriority.low == priority) return "Low";
    if (TaskPriority.medium == priority) return "Medium";
    if (TaskPriority.high == priority) return "High";
    return "None";
  }

  String get subtaskProgressString => "$numSubtasksFinished / $numSubtasks";

  int get numSubtasks => subtasks.length;

  int get numSubtasksFinished =>
      subtasks.where((Subtask subtask) => subtask.isDone).length;

  @override
  List<Object?> get props => [
        id,
        isDone,
        dateCompleted,
        dueDate,
        title,
        description,
        subtasks,
        priority
      ];

  factory Task.copyWith(
    Task task, {
    String? id,
    bool? isDone,
    DateTime? dateCompleted,
    DateTime? dueDate,
    String? title,
    String? description,
    List<Subtask>? subtasks,
    TaskPriority? priority,
  }) =>
      Task(
          id: id ?? task.id,
          isDone: isDone ?? task.isDone,
          dateCompleted: dateCompleted ?? task.dateCompleted,
          dueDate: dueDate ?? task.dueDate,
          title: title ?? task.title,
          description: description ?? task.description,
          subtasks: subtasks ?? task.subtasks,
          priority: priority ?? task.priority);

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
