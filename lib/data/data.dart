import 'package:achiever_app/constants/enums.dart';
import 'package:achiever_app/model/habit.dart';
import 'package:achiever_app/model/weekly_report.dart';
import 'package:achiever_app/model/task.dart';
import 'package:achiever_app/model/subtask.dart';
import 'package:achiever_app/model/user_data.dart';

class Data {
  final List<Habit> habits;
  final List<Task> tasks;
  final WeeklyReport weeklyReport;
  final UserHistory userHistory;

  List<Task> get tasksOverdue =>
      List<Task>.from(tasks).where((Task task) => task.isOverDue).toList();

  List<Task> get tasksDueThisWeek =>
      List<Task>.from(tasks).where((Task task) => task.isDueThisWeek).toList();

  List<Task> get tasksDueThisWeekOrUndated => List<Task>.from(tasks)
      .where((Task task) => task.isDueThisWeekOrUndated)
      .toList();

  List<Task> get tasksDueAfterThisWeek => List<Task>.from(tasks)
      .where((Task task) => task.isDueAfterThisWeek)
      .toList();

  Data({this.habits, this.tasks, this.weeklyReport, this.userHistory});
}

final data = Data(
  habits: [
    Habit(title: "Brush your teeth"),
    Habit(title: "Do some programming"),
    Habit(title: "Read your bible"),
  ],
  tasks: [
    Task(
      title: "Eat something",
      dueDate: DateTime.now(),
    ),
    Task(
      title: "Build homescreen UI",
      description: "Build a homescreen UI which displays "
          "weekly report, habits, and tasks",
      dueDate: DateTime.now().add(Duration(days: 1)),
      priority: TaskPriority.low,
      isDone: true,
      dateCompleted: DateTime(2021, 2, 2),
      subtasks: [
        Subtask(description: "Build report card widget", isDone: true),
        Subtask(description: "Build habit list widget", isDone: true),
        Subtask(description: "Build task list widget", isDone: true),
      ],
    ),
    Task(
        title: "Build add task/habit UI",
        description: "Add UI elements for adding tasks and habits",
        priority: TaskPriority.medium,
        dueDate: DateTime.now().add(Duration(days: 6)),
        subtasks: [
          Subtask(description: "Build add task UI"),
          Subtask(description: "Build add habit UI", isDone: true),
        ]),
    Task(
      title: "Build complete UI",
      description:
          "Completely build out all screens and elements necessary for the funcitoning of the app",
      dueDate: DateTime(2021, 2, 28),
      priority: TaskPriority.medium,
      subtasks: [
        Subtask(description: "Build Home screen", isDone: true),
        Subtask(description: "Build task edit / detail screen (or modal)"),
        Subtask(description: "Build habit edit modal"),
        Subtask(description: "Build task list screen"),
      ],
    ),
    Task(
      title: "Release Achiever MVP",
      description: "Get a minimum viable version "
          "of Achiever on the Google Play store.",
      priority: TaskPriority.high,
      subtasks: [
        Subtask(description: "build UI"),
        Subtask(description: "build Data layer"),
        Subtask(description: "build Buisness logic"),
        Subtask(description: "deploy app"),
      ],
    ),
  ],
  weeklyReport: WeeklyReport(
    tasksCompleted: 5,
    tasksDue: 7,
    tasksDoneOnTimeStreak: 10,
    dailyHabitStreak: 36,
    tasksDoneInWeekNewBest: false,
    onTimeNewBestStreak: false,
    habitsNewBestStreak: true,
    habitsCompletedDays: _setHabitsDoneThisWeek(),
  ),
  userHistory: UserHistory(
    mostTasksDoneInWeek: 8,
    longestTasksOnTimeStreak: 14,
    longestHabitsFinishedStreak: 36,
  ),
);

List<bool> _setHabitsDoneThisWeek() {
  var days = [false, false, false, false, false, false, false];
  int today = DateTime.now().weekday;
  for (int i = 0; i < today; i++) {
    if (i != 6) days[i] = true;
  }
  return days;
}
