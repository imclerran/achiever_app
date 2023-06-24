part of 'habits_bloc.dart';

abstract class HabitsState extends Equatable {
  final List<Habit> habits;
  const HabitsState() : habits = const [];

  @override
  List<Object> get props => [habits];
}

class HabitsInitial extends HabitsState {
  final List<Habit> habits;
  HabitsInitial() : habits = data.habits;
  get props => [habits];
}

class HabitsLoaded extends HabitsState {
  final List<Habit> habits;
  HabitsLoaded(this.habits);
  get props => [habits];
}
