import 'package:achiever_app/bloc/habits/habits_bloc.dart';
import 'package:achiever_app/data/app_theme.dart';
import 'package:achiever_app/model/habit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:vibration/vibration.dart';

import 'edit_habit_modal.dart';

class HabitCard extends StatelessWidget {
  final Habit habit;

  const HabitCard({Key key, this.habit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = AppTheme(MediaQuery.of(context).platformBrightness);
    return GestureDetector(
      onTap: () {
        // ignore: close_sinks
        var habitsBloc = BlocProvider.of<HabitsBloc>(context);
        habitsBloc.add(ToggleHabitDoneToday(habit));
      },
      onLongPress: () async {
        if (await Vibration.hasAmplitudeControl()) {
          Vibration.vibrate(amplitude: 255, duration: 10);
        }
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) => EditHabitModal(habit),
        );
      },
      child: Container(
        margin: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: AppThemeLight.accentColor,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Row(
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 60),
                  curve: Curves.bounceInOut,
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    border: habit.isDoneToday
                        ? null
                        : Border.all(
                            width: 4.0,
                            color: AppThemeLight.accentColor2,
                          ),
                  ),
                  child: habit.isDoneToday
                      ? Icon(FontAwesome.check,
                          color: AppThemeLight.accentColor2)
                      : Icon(FontAwesome.check, color: Colors.transparent),
                ),
                SizedBox(width: 8),
                Text(
                  habit.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: AppThemeLight.h5.fontSize,
                    fontWeight: AppThemeLight.h5.fontWeight,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
