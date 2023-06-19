import 'package:achiever_app/model/task.dart';
import 'package:achiever_app/widgets/habit_list.dart';
import 'package:achiever_app/widgets/report_card.dart';
import 'package:achiever_app/widgets/task_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:achiever_app/data/data.dart';
import 'package:achiever_app/data/app_theme.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasksDueThisWeek = data.tasksDueThisWeekOrUndated;
  List<Task> tasksDueAfterThisWeek = data.tasksDueAfterThisWeek;

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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: theme.primaryColor,
            forceElevated: true,
            floating: true,
            elevation: 4,
            brightness: theme.brightness,
            flexibleSpace: FlexibleSpaceBar(
              title: GradientText(
                "Achiever",
                gradient: LinearGradient(colors: [
                  AppThemeLight.accentColor,
                  AppThemeLight.accentColor2
                ]),
                style: TextStyle(
                  fontSize: 32.0,
                  color: AppThemeLight.accentColor,
                ),
              ),
              centerTitle: true,
              titlePadding: EdgeInsets.all(8.0),
            ),
            actions: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: TextButton(
                  /*FlatButton(*/
                  onPressed: () {},
                  child: Row(
                    children: [
                      Icon(
                        FontAwesome.plus,
                        color: AppThemeLight.accentColor,
                        size: 22.0,
                      ),
                      SizedBox(width: 4),
                      Text(
                        "New",
                        style: AppThemeLight.h3,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              _homescreenSliverBuilder,
              childCount: sliverListCount,
            ),
          ),
        ],
      ),
    );
  }

  String _getGreeting() {
    var hourNow = DateTime.now().hour;
    if (hourNow < 12) return "Good Morning!";
    if (hourNow < 17) return "Good Afternoon!";
    return "Good Evening!";
  }

  int get sliverListOffsetThisWeek => 4;

  int get sliverListOffsetAfterThisWeek {
    int numDueThisWeek = tasksDueThisWeek.length;
    return 4 + (numDueThisWeek > 0 ? numDueThisWeek : 1);
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
}
