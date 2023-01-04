import 'package:achiever_app/data/app_theme.dart';
import 'package:achiever_app/widgets/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:achiever_app/data/data.dart';

class ReportCard extends StatefulWidget {
  @override
  _ReportCardState createState() => _ReportCardState();
}

class _ReportCardState extends State<ReportCard> {
  @override
  Widget build(BuildContext context) {
    var theme = AppTheme(MediaQuery.of(context).platformBrightness);
    return Container(
      margin: EdgeInsets.all(8.0),
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Your Weekly Progress", style: AppThemeLight.h3),
            SizedBox(height: 8.0),
            _buildTaskProgressCard(theme),
            SizedBox(height: 8.0),
            _buildHabitProgressCard(theme),
            // Divider(
            //   thickness: 1.0,
            //   color: Colors.black12,
            //   height: 32,
            // ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: _buildTaskStreakCard(theme),
                ),
                SizedBox(width: 8.0),
                Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: _buildHabitStreakCard(theme),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget _buildTaskProgressCard(AppTheme theme) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: theme.cardColor2,
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Tasks Due This Week:", style: theme.h5),
              Text(
                "${data.weeklyReport.tasksCompleted} / ${data.weeklyReport.tasksDue} Completed",
                style: theme.h6,
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ProgressBar(
                data.weeklyReport.tasksCompleted, data.weeklyReport.tasksDue),
          ),
          SizedBox(height: 8.0),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Complete ',
              style: theme.text,
              children: [
                TextSpan(
                  text:
                      '${data.userHistory.mostTasksDoneInWeek - data.weeklyReport.tasksCompleted + 1}',
                  style: TextStyle(color: theme.accentColor),
                ),
                TextSpan(
                  text: ' more tasks this week to set a new record!',
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

Widget _buildHabitProgressCard(AppTheme theme) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: theme.cardColor2,
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "All habits completed:",
                style: theme.h5,
              ),
              Text(
                "${data.weeklyReport.numDayshabitsDone} / ${DateTime.now().weekday} days",
                style: theme.h6,
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Row(
            children: [
              for (int day in [0, 1, 2, 3, 4, 5, 6]) _buildHabitDay(day, theme),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _buildHabitDay(int day, AppTheme theme) {
  var dayNames = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
  return Flexible(
    flex: 1,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(dayNames[day], style: theme.text),
          SizedBox(height: 4),
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: data.weeklyReport.habitsCompletedDays[day]
                  ? theme.accentColor
                  : theme.disabledColor,
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildTaskStreakCard(AppTheme theme) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0), color: theme.cardColor2),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Tasks on time streak:",
            style: theme.h5,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                FontAwesome5Solid.fire,
                color: theme.accentColor,
                size: 20,
              ),
              Text(
                " ${data.weeklyReport.tasksDoneOnTimeStreak} days",
                style: theme.h3,
              ),
            ],
          ),
          SizedBox(height: 4.0),
          Text(
            data.weeklyReport.onTimeNewBestStreak
                ? "NEW RECORD!"
                : "Best: ${data.userHistory.longestTasksOnTimeStreak} days",
            style: theme.text,
          ),
        ],
      ),
    ),
  );
}

Widget _buildHabitStreakCard(AppTheme theme) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0), color: theme.cardColor2),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Habits finished streak:",
            style: theme.h5,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                FontAwesome5Solid.fire,
                color: theme.accentColor,
                size: 20,
              ),
              Text(
                " ${data.weeklyReport.dailyHabitStreak} days",
                style: theme.h3,
              ),
            ],
          ),
          SizedBox(height: 4.0),
          Text(
            data.weeklyReport.habitsNewBestStreak
                ? "NEW RECORD!"
                : "Best: ${data.userHistory.longestHabitsFinishedStreak} days",
            style: theme.text,
          ),
        ],
      ),
    ),
  );
}
