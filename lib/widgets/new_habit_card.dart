import 'package:achiever_app/data/app_theme.dart';
import 'package:achiever_app/widgets/new_habit_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';

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
      return NewHabitModal();
    },
  );
}

Widget _buildModalTitleRow(AppTheme theme) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(10.0),
    child: Container(
      padding: EdgeInsets.all(8.0),
      color: theme.cardColor,
      child: Row(
        children: [
          // Text("Title:", style: theme.h5),
          // SizedBox(width: 4.0),
          Expanded(
            child: Theme(
              data: ThemeData(
                hintColor: theme.h6.color,
                //accentColor: theme.accentColor,
                // TODO: Figure out what purpose accent color served, replace with new theme equivalent
              ),
              child: TextField(
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
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
                    hintText: "Name your new habit..."
                    //enabledBorder: OutlineInputBorder(),
                    ),
                style: theme.h6,
                cursorColor: theme.accentColor,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildModalButtonRow(BuildContext context, AppTheme theme) {
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
        onPressed: () {},
        child: Text("SAVE", style: theme.h4),
      ),
    ],
  );
}
