import 'package:achiever_app/bloc/habits/habits_bloc.dart';
import 'package:achiever_app/data/app_theme.dart';
import 'package:achiever_app/model/habit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewHabitModal extends StatefulWidget {
  @override
  _NewHabitModalState createState() => _NewHabitModalState();
}

class _NewHabitModalState extends State<NewHabitModal> {
  var titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = AppTheme(MediaQuery.platformBrightnessOf(context));
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: const Radius.circular(10.0),
        topRight: const Radius.circular(10.0),
      ),
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        color: theme.cardColor2,
        // height: 300,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("New Habit", style: theme.h2),
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
                    hintColor: theme.h6.color, accentColor: theme.accentColor),
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
                    // suffixIcon: controller.text.isEmpty
                    //     ? SizedBox(width: 0)
                    //     : IconButton(
                    //         icon: Icon(
                    //           Icons.close,
                    //           color: theme.accentColor,
                    //         ),
                    //         onPressed: () => controller.clear(),
                    //       ),
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
            Navigator.pop(context);
          },
          child: Text("CANCEL", style: theme.h4),
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
            habitsBloc.add(AddHabit(Habit(title: controller.text)));
            Navigator.of(context).pop();
          },
          child: Text("SAVE", style: theme.h4),
        ),
      ],
    );
  }
}
