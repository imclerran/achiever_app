import 'package:achiever_app/bloc/habits/habits_bloc.dart';
import 'package:achiever_app/data/app_theme.dart';
import 'package:achiever_app/model/habit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'habit_modal_buttons.dart';

enum HabitModalType { edit, create }

class HabitModal extends StatefulWidget {
  final Habit? habit;
  final HabitModalType modalType;
  const HabitModal({Key? key, Habit? habit})
      : this.habit = habit,
        this.modalType =
            (null == habit) ? HabitModalType.create : HabitModalType.edit,
        super(key: key);
  @override
  _HabitModalState createState() => _HabitModalState();
}

class _HabitModalState extends State<HabitModal> {
  var titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleController.text =
        (HabitModalType.edit == widget.modalType) ? widget.habit!.title : "";
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
              Text(
                (HabitModalType.edit == widget.modalType)
                    ? "Edit Habit"
                    : "New Habit",
                style: theme.h3,
              ),
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
                    hintText: (HabitModalType.create == widget.modalType)
                        ? "Name your new habit..."
                        : "Name your habit",
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
        (HabitModalType.create == widget.modalType)
            ? _CancelNewHabitButton()
            : _DeleteHabitButton(widget.habit!),
        SizedBox(width: 8.0),
        (HabitModalType.create == widget.modalType)
            ? _SaveNewHabitButton(controller)
            : _SaveUpdatedHabitButton(widget.habit!, controller),
      ],
    );
  }
}
