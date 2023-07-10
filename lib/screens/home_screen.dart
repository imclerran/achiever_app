import 'package:achiever_app/model/task.dart';
import 'package:achiever_app/widgets/habit/habit_list.dart';
import 'package:achiever_app/widgets/home_app_bar.dart';
import 'package:achiever_app/widgets/report_card.dart';
import 'package:achiever_app/widgets/task_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:achiever_app/data/app_theme.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';

import '../bloc/tasks/tasks_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasksDueThisWeek = [];
  List<Task> tasksDueAfterThisWeek = [];

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.platformBrightnessOf(context);
    var theme = AppTheme(brightness);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: theme.backgroundColor,
    ));
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: BlocBuilder(
        bloc: BlocProvider.of<TasksBloc>(context),
        builder: (context, state) {
          if (state is TasksLoaded) {
            tasksDueThisWeek =
                state.tasks.where((task) => task.isDueThisWeek).toList();
            tasksDueAfterThisWeek = state.tasks
                .where((task) => task.isDueAfterThisWeekOrUndated)
                .toList();
          } else {
            tasksDueThisWeek = [];
            tasksDueAfterThisWeek = [];
          }
          return CustomScrollView(
            slivers: [
              HomeAppBar(),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  _homescreenSliverBuilder,
                  childCount: sliverListCount,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _getGreeting() {
    var hourNow = DateTime.now().hour;
    if (hourNow < 12) return "Good Morning!";
    if (hourNow < 18) return "Good Afternoon!";
    return "Good Evening!";
  }

  int get sliverListOffsetThisWeek => 4;

  int get sliverListOffsetAfterThisWeek {
    int numExtraSlivers = 4;
    int numDueThisWeek = tasksDueThisWeek.length;
    return numExtraSlivers + (numDueThisWeek > 0 ? numDueThisWeek : 1);
  }

  int get sliverListCount {
    int numExtraSlivers = 4;
    int numDueThisWeek = tasksDueThisWeek.length;
    int numDueAfterThisWeek = tasksDueAfterThisWeek.length;
    numExtraSlivers += numDueThisWeek > 0 ? 0 : 1;
    numExtraSlivers += numDueAfterThisWeek > 0 ? 1 : 0;
    return numDueThisWeek + numDueAfterThisWeek + numExtraSlivers;
  }

  Widget _homescreenSliverBuilder(BuildContext context, int index) {
    var theme = AppTheme(MediaQuery.of(context).platformBrightness);
    if (0 == index) {
      return Padding(
        padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
        child: Center(
          child: Text(
            _getGreeting(),
            style: theme.h1,
          ),
        ),
      );
    }
    if (1 == index) {
      return ReportCard();
    }
    if (2 == index) {
      return HabitList();
    }
    if (3 == index) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Center(
          child: Text("Due This Week:", style: theme.h2),
        ),
      );
    }
    if (tasksDueThisWeek.length > 0 && index < sliverListOffsetAfterThisWeek)
      return TaskCard(tasksDueThisWeek[index - sliverListOffsetThisWeek]);
    else if (tasksDueThisWeek.length == 0) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Center(
          child: Text(
            "You're all caught up... What's next?",
            style: theme.h4,
          ),
        ),
      );
    }
    if (index == sliverListOffsetAfterThisWeek) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Center(
          child: Text("Down The Road:", style: theme.h2),
        ),
      );
    }
    if (tasksDueAfterThisWeek.length > 0 &&
        index > sliverListOffsetAfterThisWeek)
      return TaskCard(
          tasksDueAfterThisWeek[index - sliverListOffsetAfterThisWeek - 1]);
    return Container();
  }

  Widget _buildNewTaskActionButton(BuildContext context) {
    var theme = AppTheme(MediaQuery.platformBrightnessOf(context));
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: TextButton(
        onPressed: () {},
        child: Row(
          children: [
            Icon(
              FontAwesome.plus,
              color: theme.accentColor,
              size: 22.0,
            ),
            SizedBox(width: 4),
            Text(
              "New",
              style: theme.h3,
            ),
          ],
        ),
      ),
    );
  }
}
