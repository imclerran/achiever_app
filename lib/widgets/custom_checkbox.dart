import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class CustomCheckbox extends StatefulWidget {
  final Function onPressed;
  final bool defaultState;
  final double size;
  final double borderRadius;
  final double borderThickness;
  final Color uncheckedColor;
  final Color borderColor;
  final Color iconColor;
  final Color checkedColor;

  const CustomCheckbox({
    Key key,
    this.onPressed,
    this.defaultState = false,
    this.size = 24,
    this.borderRadius = 6,
    this.borderThickness = 4,
    this.uncheckedColor = Colors.transparent,
    this.borderColor = Colors.white,
    this.checkedColor = Colors.blue,
    this.iconColor = Colors.white,
  }) : super(key: key);

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  //bool _isSelected;
  bool _isSelected = false;
  bool _isInitialized = false;

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      _isInitialized = true;
      _isSelected = widget.defaultState;
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
          //if (null != widget.onPressed) widget.onPressed(_isSelected);
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 60),
        curve: Curves.bounceInOut,
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: _isSelected ? widget.checkedColor : widget.uncheckedColor,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: _isSelected
              ? null
              : Border.all(
                  width: widget.borderThickness,
                  color: widget.borderColor,
                ),
        ),
        child: _isSelected
            ? Icon(FontAwesome.check, color: widget.iconColor)
            : Icon(FontAwesome.check, color: Colors.transparent),
      ),
    );
  }
}
