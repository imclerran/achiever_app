part of 'habit_modal.dart';

class _DeleteHabitButton extends StatelessWidget {
  final Habit habit;
  const _DeleteHabitButton(this.habit, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = AppTheme(MediaQuery.platformBrightnessOf(context));
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: theme.errorColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onPressed: () {
        // ignore: close_sinks
        var habitsBloc = BlocProvider.of<HabitsBloc>(context);
        habitsBloc.add(DeleteHabit(habit));
        Navigator.pop(context);
      },
      child: Text("DELETE", style: theme.h4),
    );
  }
}

class _CancelNewHabitButton extends StatelessWidget {
  const _CancelNewHabitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = AppTheme(MediaQuery.platformBrightnessOf(context));
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: theme.errorColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text("CANCEL", style: theme.h4),
    );
  }
}

class _SaveNewHabitButton extends StatelessWidget {
  final TextEditingController controller;
  const _SaveNewHabitButton(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = AppTheme(MediaQuery.platformBrightnessOf(context));
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: theme.accentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onPressed: () {
        // ignore: close_sinks
        var habitsBloc = BlocProvider.of<HabitsBloc>(context);
        habitsBloc.add(AddHabit(Habit(title: controller.text)));
        Navigator.of(context).pop();
      },
      child: Text("SAVE", style: theme.h4),
    );
  }
}

class _SaveUpdatedHabitButton extends StatelessWidget {
  final Habit habit;
  final TextEditingController controller;
  const _SaveUpdatedHabitButton(this.habit, this.controller, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = AppTheme(MediaQuery.platformBrightnessOf(context));
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: theme.accentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onPressed: () {
        // ignore: close_sinks
        var habitsBloc = BlocProvider.of<HabitsBloc>(context);
        habitsBloc.add(
          UpdateHabit(
            Habit(
              id: habit.id,
              title: controller.text,
              doneDays: habit.doneDays,
            ),
          ),
        );
        Navigator.of(context).pop();
      },
      child: Text("SAVE", style: theme.h4),
    );
  }
}
