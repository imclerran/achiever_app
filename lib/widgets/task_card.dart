import 'package:achiever_app/constants/enums.dart';
import 'package:achiever_app/data/app_theme.dart';
import 'package:achiever_app/model/task.dart';
import 'package:achiever_app/widgets/progress_bar.dart';
import 'package:flutter/material.dart';

import 'custom_checkbox.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard(this.task, {Key? key}) : super(key: key);

  Color _getPriorityColor(Task task, AppTheme theme) {
    if (task.priority == TaskPriority.low) return theme.okayColor;
    if (task.priority == TaskPriority.medium) return theme.warningColor;
    if (task.priority == TaskPriority.high) return theme.errorColor;
    return theme.subtext.color!;
  }

  Color _getDueDateColor(Task task, AppTheme theme) {
    if (null == task.dueDate) return theme.errorColor;
    if (task.isDueToday) return theme.warningColor;
    if (task.isDueTomorrow) return theme.okayColor;
    if (task.isOverDue) return theme.errorColor;
    return theme.okayColor;
  }

  Color _getSubtaskColor(Task task, AppTheme theme) {
    if (task.numSubtasks == 0) return theme.subtext.color!;
    if (task.numSubtasks == task.numSubtasksFinished) return theme.okayColor;
    return theme.okayColor;
  }

  List<Widget> _getDueDateTexts(Task task, AppTheme theme) {
    return [
      Text("Achieve: ", style: theme.subtext),
      Text(
        task.dueDateString,
        style: TextStyle(
          color: _getDueDateColor(task, theme),
          fontSize: theme.subtext.fontSize,
          fontWeight: theme.subtext.fontWeight,
        ),
      ),
    ];
  }

  List<Widget> _getSubtaskTexts(Task task, AppTheme theme) {
    return [
      Text(
        "  |  Subtasks: ",
        style: theme.subtext,
      ),
      Text(
        task.subtaskProgressString,
        style: TextStyle(
          color: _getSubtaskColor(task, theme),
          fontSize: theme.subtext.fontSize,
          fontWeight: theme.subtext.fontWeight,
        ),
      ),
    ];
  }

  List<Widget> _getPriorityTexts(Task task, AppTheme theme) {
    return [
      Text(
        "  |  Priority: ",
        style: theme.subtext,
      ),
      Text(
        task.priorityString,
        style: TextStyle(
          color: _getPriorityColor(task, theme),
          fontSize: theme.subtext.fontSize,
          fontWeight: theme.subtext.fontWeight,
        ),
      ),
    ];
  }

  List<Widget> _getDetailRowChildren(BuildContext context, task) {
    double screenWidth = MediaQuery.of(context).size.width;
    var theme = AppTheme(MediaQuery.platformBrightnessOf(context));
    bool useDueDate = true; //null != task.dueDate;
    bool useSubtask = task.numSubtasks > 0;
    bool usePriority = TaskPriority.none != task.priority;
    int maxSegments = screenWidth > 390 ? 3 : 2;
    int availableSegments = [useDueDate, useSubtask, usePriority]
        .where((bool element) => element)
        .length;
    useSubtask = useSubtask && availableSegments <= maxSegments;
    // TODO: find elegant way to insert dividers
    return [
      if (useDueDate) ..._getDueDateTexts(task, theme),
      if (useSubtask) ..._getSubtaskTexts(task, theme),
      if (usePriority) ..._getPriorityTexts(task, theme),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var theme = AppTheme(MediaQuery.of(context).platformBrightness);
    return Container(
      margin: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
      height: task.description == "" ? 60 : 85,
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor,
            offset: Offset(0, 2),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Material(
          color: theme.cardColor,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Padding(
                padding: task.numSubtasks > 0
                    ? EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 16.0)
                    : EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CustomCheckbox(
                      onPressed: () => {},
                      defaultState: task.isDone, // TODO: default to done?
                      borderColor: AppThemeLight.accentColor,
                      checkedColor: Colors.transparent,
                      iconColor: AppThemeLight.accentColor,
                    ),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(task.title,
                              overflow: TextOverflow.ellipsis, style: theme.h4),
                          if (task.description != "")
                            Text(
                              task.description,
                              overflow: TextOverflow.ellipsis,
                              style: theme.h5,
                            ),
                          Row(
                            children: _getDetailRowChildren(context, task),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (task.numSubtasks > 0)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: 8,
                  child:
                      ProgressBar(task.numSubtasksFinished, task.numSubtasks),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
