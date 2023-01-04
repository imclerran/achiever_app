part of 'habits_bloc.dart';

abstract class HabitsState extends Equatable {
  const HabitsState();

  @override
  List<Object> get props => [];
}

class HabitsInitial extends HabitsState {}

class HabitsLoading extends HabitsState {}

class HabitsLoaded extends HabitsState {
  final List<Habit> habits;
  HabitsLoaded(this.habits);
  get props => [habits];
}

class HabitsUpdated extends HabitsLoaded {
  final Habit updated;
  HabitsUpdated(List<Habit> habits, this.updated) : super(habits);
  get props => [habits, updated];
}

class HabitsNotLoaded extends HabitsState {}
