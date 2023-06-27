import 'package:achiever_app/bloc/habits/habits_bloc.dart';
import 'package:achiever_app/data/app_theme.dart';
import 'package:achiever_app/model/habit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditHabitModal extends StatefulWidget {
  final Habit habit;
  const EditHabitModal(this.habit, {Key? key}) : super(key: key);
  @override
  _EditHabitModalState createState() => _EditHabitModalState();
}

class _EditHabitModalState extends State<EditHabitModal> {
  var titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleController.text = widget.habit.title;
    var theme = AppTheme(MediaQuery.platformBrightnessOf(context));
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: const Radius.circular(10.0),
        topRight: const Radius.circular(10.0),
      ),
      child: Container(
        //constraints: BoxConstraints(maxHeight: 550),
        //height: 521,
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        color: theme.cardColor2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Edit Habit", style: theme.h3),
              SizedBox(height: 8.0),
              _buildModalTitleRow(titleController, theme),
              SizedBox(height: 4.0),
              _buildModalButtonRow(context, titleController, theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModalTitleRow(TextEditingController controller, AppTheme theme) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        padding: EdgeInsets.all(8.0),
        color: theme.cardColor,
        child: Row(
          children: [
            Expanded(
              child: Theme(
                data: ThemeData(
                  hintColor: theme.h6.color,
                  //accentColor: theme.accentColor, TODO: update themes to new theme standards
                ),
                child: TextField(
                  autofocus: true,
                  controller: controller,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  style: theme.h6,
                  cursorColor: theme.accentColor,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    disabledBorder:
                        OutlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2.0,
                        color: theme.accentColor,
                      ),
                    ),
                    labelText: "Habit Title",
                    hintText: "Name your new habit...",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModalButtonRow(
      BuildContext context, TextEditingController controller, AppTheme theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: theme.errorColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onPressed: () {
            // ignore: close_sinks
            var habitsBloc = BlocProvider.of<HabitsBloc>(context);
            habitsBloc.add(DeleteHabit(widget.habit));
            Navigator.pop(context);
          },
          child: Text("DELETE", style: theme.h4),
        ),
        SizedBox(width: 8.0),
        TextButton(
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
                  id: widget.habit.id,
                  title: controller.text,
                  doneDays: widget.habit.doneDays,
                ),
              ),
            );
            Navigator.of(context).pop();
          },
          child: Text("SAVE", style: theme.h4),
        ),
      ],
    );
  }
}
