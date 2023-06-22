part of 'habits_bloc.dart';

abstract class HabitsState extends Equatable {
  const HabitsState();

  @override
  List<Object> get props => [];
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
