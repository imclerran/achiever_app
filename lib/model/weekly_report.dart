import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class WeeklyReport extends Equatable {
  DateTime weekBegins;
  int tasksCreated;
  int tasksCompleted;
  int tasksDue;
  int tasksDoneOnTimeStreak;
  int dailyHabitStreak;
  int weeklyHabitStreak;
  bool tasksDoneInWeekNewBest;
  bool onTimeNewBestStreak;
  bool habitsNewBestStreak;
  List<bool> habitsCompletedDays;

  int get numDayshabitsDone =>
      habitsCompletedDays.where((bool completed) => completed).length;

  WeeklyReport({
    this.weekBegins,
    this.tasksCreated,
    this.tasksCompleted,
    this.tasksDue,
    this.tasksDoneOnTimeStreak,
    this.dailyHabitStreak,
    this.tasksDoneInWeekNewBest,
    this.onTimeNewBestStreak,
    this.habitsNewBestStreak,
    this.habitsCompletedDays,
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
