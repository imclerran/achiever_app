import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../data/app_theme.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({Key? key}) : super(key: key);

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
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        elevation: 4,
        flexibleSpace: FlexibleSpaceBar(
          title: GradientText(
            "Achiever",
            colors: [AppThemeLight.accentColor, AppThemeLight.accentColor2],
            style: TextStyle(
              fontSize: 32,
              color: AppThemeLight.accentColor,
            ),
          ),
          centerTitle: true,
          titlePadding: EdgeInsets.all(8.0),
        ),
      ),
    );
  }
}
