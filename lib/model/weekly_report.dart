import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class WeeklyReport extends Equatable {
  final DateTime weekBegins;
  final int tasksCreated;
  final int tasksCompleted;
  final int tasksDue;
  final int tasksDoneOnTimeStreak;
  final int dailyHabitStreak;
  final int weeklyHabitStreak;
  final bool tasksDoneInWeekNewBest;
  final bool onTimeNewBestStreak;
  final bool habitsNewBestStreak;
  final List<bool> habitsCompletedDays;

  int get numDayshabitsDone =>
      habitsCompletedDays.where((bool completed) => completed).length;

  WeeklyReport({
    required this.weekBegins,
    required this.tasksCreated,
    required this.tasksCompleted,
    required this.tasksDue,
    required this.tasksDoneOnTimeStreak,
    required this.dailyHabitStreak,
    required this.weeklyHabitStreak,
    required this.tasksDoneInWeekNewBest,
    required this.onTimeNewBestStreak,
    required this.habitsNewBestStreak,
    required this.habitsCompletedDays,
  });

  @override
  List<Object> get props => [
        weekBegins,
        tasksCreated,
        tasksCompleted,
        tasksDue,
        tasksDoneOnTimeStreak,
        dailyHabitStreak,
        tasksDoneInWeekNewBest,
        onTimeNewBestStreak,
        habitsNewBestStreak,
        habitsCompletedDays,
      ];
}
