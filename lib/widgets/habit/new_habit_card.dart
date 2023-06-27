import 'package:achiever_app/data/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';

import 'habit_modal.dart';

class NewHabitCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = AppTheme(MediaQuery.platformBrightnessOf(context));
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor,
              offset: const Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: TextButton(
            /*FlatButton(*/
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 0),
            ),
            // padding: EdgeInsets.symmetric(horizontal: 0),
            onPressed: () {
              _showModalBottomSheet(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Row(
                  children: [
                    Icon(
                      FontAwesome.plus,
                      color: theme.accentColor,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "New Habit",
                      style: TextStyle(
                        color: theme.accentColor,
                        fontSize: theme.h5.fontSize,
                        fontWeight: theme.h5.fontWeight,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

_showModalBottomSheet(BuildContext context) {
  //var theme = AppTheme(MediaQuery.platformBrightnessOf(context));
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return HabitModal();
    },
  );
}
