import 'package:achiever_app/data/app_theme.dart';
import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final int total;
  final int progress;
  final double borderRadius;
  final double height;

  const ProgressBar(this.progress, this.total,
      {Key? key, this.borderRadius = 4, this.height = 8})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var theme = AppTheme(MediaQuery.of(context).platformBrightness);
    return Row(
      children: [
        Expanded(
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: Container(
                  height: height,
                  decoration: BoxDecoration(
                    color: theme.disabledColor,
                  ),
                ),
              ),
              Row(
                children: [
                  Flexible(
                    flex: progress,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(borderRadius),
                      child: Container(
                        height: height,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              theme.accentColor,
                              theme.accentColor2,
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: total - progress,
                    child: Container(
                      height: height,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
