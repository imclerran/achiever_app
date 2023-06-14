import 'package:achiever_app/data/app_theme.dart';
import 'package:achiever_app/data/data.dart';
import 'package:achiever_app/widgets/task_card.dart';
import 'package:flutter/material.dart';

class TasksThisWeekList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Center(
            child: Text("Due This Week:", style: AppThemeLight.h2),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(bottom: 60.0),
        //   child: Center(
        //     child: Text("Great job! You're all caught up... What's next?",
        //         style: AppThemeLight.h6),
        //   ),
        // ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return TaskCard(data.tasks[index]);
            },
            childCount: data.tasks.length,
          ),
        )
      ],
    );
  }
}
