part of 'habits_bloc.dart';

abstract class HabitsEvent extends Equatable {
  const HabitsEvent();

  @override
  List<Object> get props => [];
}

class LoadHabits extends HabitsEvent {}

class AddHabit extends HabitsEvent {
  final Habit habit;
  AddHabit(this.habit);
  get props => [habit];
}

class UpdateHabit extends HabitsEvent {
  final Habit habit;
  UpdateHabit(this.habit);
  get props => [habit];
}

class ToggleHabitDoneToday extends HabitsEvent {
  final Habit habit;
  ToggleHabitDoneToday(this.habit);
  get props => [habit];
}

class DeleteHabit extends HabitsEvent {
  final Habit habit;
  DeleteHabit(this.habit);
  get props => [habit];
}

class ResetAllHabits extends HabitsEvent {}
