import 'dart:convert';

import 'package:achiever_app/data/data.dart';
import 'package:achiever_app/model/habit.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'habits_event.dart';
part 'habits_state.dart';

class HabitsBloc extends HydratedBloc<HabitsEvent, HabitsState> {
  HabitsBloc() : super(HabitsInitial()) {
    on<LoadHabits>(_onLoadHabits);
    on<AddHabit>(_onAddHabit);
    on<DeleteHabit>(_onDeleteHabit);
    on<UpdateHabit>(_onUpdateHabit);
    on<ResetAllHabits>(_onResetAllHabits);
    on<ToggleHabitDoneToday>(_onToggleHabit);
  }

  void _onLoadHabits(LoadHabits event, Emitter<HabitsState> emit) {
    Map<String, dynamic> habitsJson = HydratedBloc.storage.read('HabitsBloc');
    HabitsLoaded habitsState = fromJson(habitsJson) as HabitsLoaded;
    emit(habitsState);
  }

  void _onAddHabit(AddHabit event, Emitter<HabitsState> emit) {
    if (state is HabitsLoaded) {
      List<Habit> updatedList = List.from((state as HabitsLoaded).habits)
        ..add(event.habit);
      emit(HabitsLoaded(updatedList));
    }
  }

  void _onDeleteHabit(DeleteHabit event, Emitter<HabitsState> emit) {
    if (state is HabitsLoaded) {
      final List<Habit> updatedList = (state as HabitsLoaded)
          .habits
          .where((habit) => habit.id != event.habit.id)
          .toList();
      emit(HabitsLoaded(updatedList));
    }
  }

  void _onUpdateHabit(UpdateHabit event, Emitter<HabitsState> emit) {
    if (state is HabitsLoaded) {
      final List<Habit> updatedList =
          (state as HabitsLoaded).habits.map((habit) {
        return habit.id == event.habit.id ? event.habit : habit;
      }).toList();
      emit(HabitsLoaded(updatedList));
    }
  }

  void _onResetAllHabits(ResetAllHabits event, Emitter<HabitsState> emit) {
    if (state is HabitsLoaded) {
      final List<Habit> updatedHabits = (state as HabitsLoaded)
          .habits
          .map(
            (habit) => Habit(
              id: habit.id,
              title: habit.title,
              doneDays: [false, false, false, false, false, false, false],
            ),
          )
          .toList();
      emit(HabitsLoaded(updatedHabits));
    }
  }

  void _onToggleHabit(ToggleHabitDoneToday event, Emitter<HabitsState> emit) {
    if (state is HabitsLoaded) {
      bool status = event.habit.isDoneToday;
      var weekday = DateTime.now().weekday;
      List<bool> doneDays = List.from(event.habit.doneDays);
      doneDays[weekday - 1] = !status;
      var updatedHabit = Habit(
        id: event.habit.id,
        title: event.habit.title,
        doneDays: doneDays,
      );
      final List<Habit> updatedList =
          (state as HabitsLoaded).habits.map((habit) {
        return habit.id == updatedHabit.id ? updatedHabit : habit;
      }).toList();
      emit(HabitsLoaded(updatedList));
    }
  }

  @override
  HabitsState? fromJson(Map<String, dynamic> json) {
    List<dynamic> habitsJson = jsonDecode(json['habits']);
    List<Habit> habits = List.empty(growable: true);
    for (Map<String, dynamic> habitJson in habitsJson) {
      habits.add(Habit.fromJson(habitJson));
    }
    return HabitsLoaded(habits);
  }

  @override
  Map<String, dynamic>? toJson(HabitsState state) {
    if (state is HabitsLoaded) {
      String habitsJson = jsonEncode(state.habits);
      return {'habits': habitsJson};
    } else if (state is HabitsInitial) {
      String habitsJson = jsonEncode(state.habits);
      return {'habits': habitsJson};
    } else {
      return {'habits': '[]'};
    }
  }
}
