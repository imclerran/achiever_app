import 'dart:async';

import 'package:achiever_app/data/data.dart';
import 'package:achiever_app/model/habit.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'habits_event.dart';
part 'habits_state.dart';

class HabitsBloc extends Bloc<HabitsEvent, HabitsState> {
  HabitsBloc() : super(HabitsInitial());

  //HabitsState get initialState => HabitsInitial();

  @override
  Stream<HabitsState> mapEventToState(
    HabitsEvent event,
  ) async* {
    if (event is LoadHabits) {
      yield* _mapLoadHabitsToState(event);
    }
    if (event is AddHabit) {
      yield* _mapAddHabitToState(event);
    }
    if (event is UpdateHabit) {
      yield* _mapUpdateHabitToState(event);
    }
    if (event is ToggleHabitDoneToday) {
      yield* _mapToggleHabitToState(event);
    }
    if (event is DeleteHabit) {
      yield* _mapDeleteHabitToState(event);
    }
    if (event is ResetAllHabits) {
      yield* _mapResetAllHabitsToState(event);
    }
  }

  Stream<HabitsState> _mapAddHabitToState(AddHabit event) async* {
    if (state is HabitsLoaded) {
      List<Habit> updatedList = List.from((state as HabitsLoaded).habits)
        ..add(event.habit);
      yield HabitsLoaded(updatedList);
    }
  }

  Stream<HabitsState> _mapDeleteHabitToState(DeleteHabit event) async* {
    if (state is HabitsLoaded) {
      final List<Habit> updatedList = (state as HabitsLoaded)
          .habits
          .where((habit) => habit.id != event.habit.id)
          .toList();
      yield HabitsLoaded(updatedList);
    }
  }

  Stream<HabitsState> _mapLoadHabitsToState(LoadHabits event) async* {
    if (state is HabitsNotLoaded || state is HabitsInitial) {
      yield HabitsLoading();
      yield HabitsLoaded(data.habits);
      //yield HabitsLoaded([]);
    }
  }

  Stream<HabitsState> _mapResetAllHabitsToState(ResetAllHabits event) async* {
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
      yield HabitsLoaded(updatedHabits);
    }
  }

  Stream<HabitsState> _mapToggleHabitToState(
    ToggleHabitDoneToday event,
  ) async* {
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
      yield HabitsLoaded(updatedList);
    }
  }

  Stream<HabitsState> _mapUpdateHabitToState(UpdateHabit event) async* {
    if (state is HabitsLoaded) {
      final List<Habit> updatedList =
          (state as HabitsLoaded).habits.map((habit) {
        return habit.id == event.habit.id ? event.habit : habit;
      }).toList();
      yield HabitsLoaded(updatedList);
    }
  }

  @override
  HabitsLoaded? fromJson(Map<String, dynamic> json) {
    try {
      final List<Habit> habits = (json["habits"] as Map<String, dynamic>)
          .values
          .map((e) => Habit.fromJson(e))
          .toList();
      return HabitsLoaded(habits);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(HabitsState state) {
    if (state is HabitsLoaded) {
      return {
        "habits": state.habits.map((habit) => habit.toJson()).toList(),
      };
    }
    return null;
  }
}
