import 'package:achiever_app/bloc/habits/habits_bloc.dart';
import 'package:achiever_app/data/app_theme.dart';
import 'package:achiever_app/model/habit.dart';
import 'package:achiever_app/widgets/new_habit_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'habit_card.dart';

class HabitList extends StatefulWidget {
  @override
  _HabitListState createState() => _HabitListState();
}

class _HabitListState extends State<HabitList> {
  //var habitsBloc = HabitsBloc()..add(LoadHabits());
  //List<Habit> habits; // TODO: verify list in widget state is unneeded
  // TODO: if possible, convert habit list to stateless widget

  @override
  Widget build(BuildContext context) {
    var theme = AppTheme(MediaQuery.of(context).platformBrightness);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: Text('Habits:', style: theme.h2),
        ),
        Container(
          height: 50.0,
          child: BlocBuilder(
            bloc: BlocProvider.of<HabitsBloc>(context), //habitsBloc,
            builder: (context, state) {
              if (state is HabitsLoaded)
                return _buildHabitListView(state.habits);
              else
                return _buildNoHabits();
            },
          ),
        ),
      ],
    );
  }

  ListView _buildHabitListView(List<Habit> habits) {
    List<Habit> habitsList = List.from(habits)
      ..sort((Habit lhs, Habit rhs) => lhs.compareTo(rhs));
    List<Widget> habitCards = [
      NewHabitCard(),
      for (var habit in habitsList) HabitCard(habit: habit),
    ];
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.only(left: 8.0, right: 8.0),
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      children: habitCards,
    );
  }

  int _getChangedIndex(List<Habit> oldList, List<Habit> newList) {
    if (oldList.length == 0 && newList.length == 1) return 0;
    if (oldList.length == 1 && newList.length == 0) return 0;
    if (oldList.length > newList.length) {
      for (int i = 0; i < oldList.length; i++) {
        if (!newList.contains(oldList[i])) return i;
      }
    }
    if (oldList.length < newList.length) {
      for (int i = 0; i < newList.length; i++) {
        if (!oldList.contains(newList[i])) return i;
      }
    }
    return -1;
  }

  Widget _buildNoHabits() {
    List<Widget> habitCards = [
      NewHabitCard(),
    ];
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.only(left: 8.0, right: 8.0),
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      children: habitCards,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
