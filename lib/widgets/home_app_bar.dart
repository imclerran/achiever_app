import 'package:achiever_app/screens/task_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../data/app_theme.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.platformBrightnessOf(context);
    var theme = AppTheme(brightness);
    return SliverAppBar(
      backgroundColor: theme.primaryColor,
      forceElevated: true,
      floating: true,
      elevation: 4,
      //brightness: theme.brightness, TODO: update theme to latest theme conventions
      flexibleSpace: FlexibleSpaceBar(
        title: GradientText(
          "Achiever",
          colors: [AppThemeLight.accentColor, AppThemeLight.accentColor2],
          style: TextStyle(
            fontSize: 32.0,
            color: AppThemeLight.accentColor,
          ),
        ),
        centerTitle: true,
        titlePadding: EdgeInsets.all(8.0),
      ),
      actions: [_buildNewTaskActionButton(context)],
    );
  }

  Widget _buildNewTaskActionButton(BuildContext context) {
    var theme = AppTheme(MediaQuery.platformBrightnessOf(context));
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskScreen(),
            ),
          );
        },
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
