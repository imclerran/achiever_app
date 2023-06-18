import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class UserHistory extends Equatable {
  final int mostTasksDoneInWeek;
  final int longestTasksOnTimeStreak;
  final int longestHabitsFinishedStreak;

  UserHistory({
    required this.mostTasksDoneInWeek,
    required this.longestTasksOnTimeStreak,
    required this.longestHabitsFinishedStreak,
  });

  @override
  List<Object> get props => [
        mostTasksDoneInWeek,
        longestTasksOnTimeStreak,
        longestHabitsFinishedStreak,
      ];
}
