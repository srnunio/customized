import 'package:flutter/material.dart';

import 'custom_progress.dart';
import 'custom_text.dart';

abstract class CustomButton extends StatelessWidget {
  final Function onPressed;
  final Color activeColor;
  final Color disabledColor;
  final String text;
  final double border;
  final double elevation;
  final double height;
  final TxtCase txtCase;
  final double textSize;
  final Color textColor;
  final bool enableEffectClicked;
  final TextStyle Function(TextStyle style) textStyle;

  const CustomButton({
    this.onPressed,
    this.enableEffectClicked = true,
    this.activeColor,
    this.disabledColor,
    this.text,
    this.txtCase,
    this.textStyle,
    this.textColor,
    this.textSize,
    this.border = 8.0,
    this.height = 50.0,
    this.elevation = 8.0,
  })  : assert(disabledColor != null),
        assert(text != null),
        assert(height != null);

  body({@required Widget child, @required BuildContext context}) {
    var _activeColor = activeColor ?? Theme.of(context).accentColor;

    return ClipRRect(
      borderRadius: BorderRadius.circular(border),
      child: MaterialButton(
        splashColor: (enableEffectClicked) ? null : Colors.transparent,
        highlightColor: (enableEffectClicked) ? null : Colors.transparent,
        disabledColor: disabledColor,
        elevation: elevation,
        color: _activeColor,
        height: height,
        minWidth: double.infinity / 2,
        child: child,
        onPressed: onPressed,
      ),
    );
  }
}

class DefaultButton extends CustomButton {
  DefaultButton(
      {@required String value,
      double border,
      double elevation,
      TextStyle Function(TextStyle style) textStyle,
      TxtCase txtCase = TxtCase.None,
      Color activeColor,
      Color disabledColor,
      double height = 50.0,
      String Function(String value) builderText,
      @required Function onPressed,
      double textSize,
      Color textColor})
      : assert(value != null),
        super(
            text: value,
            activeColor: activeColor,
            disabledColor: disabledColor ?? Colors.grey[200],
            textStyle: textStyle,
            elevation: elevation,
            height: height,
            txtCase: txtCase,
            textSize: textSize,
            textColor: textColor,
            border: border ?? 8.0,
            onPressed: onPressed);

  @override
  Widget build(BuildContext context) => body(
      context: context,
      child: Txt(
        text,
        textAlign: TextAlign.center,
        textSize: textSize,
        textColor: textColor,
        txtCase: txtCase,
        textStyle: textStyle,
      ));
}

class CustomProgressButton extends CustomButton {
  CustomProgressButton(
      {this.isLoading = false,
      this.ignorePlatform = false,
      @required String value,
      double border,
      double elevation,
      TextStyle Function(TextStyle style) textStyle,
      Color activeColor,
      Color disabledColor,
      double height = 50.0,
      TxtCase txtCase = TxtCase.None,
      String Function(String value) builderText,
      @required Function onPressed,
      double textSize,
      Color textColor})
      : assert(value != null),
        assert(isLoading != null),
        super(
            text: value,
            activeColor: activeColor,
            disabledColor: disabledColor ?? Colors.grey[200],
            textStyle: textStyle,
            txtCase: txtCase,
            textSize: textSize,
            textColor: textColor,
            elevation: elevation ?? 0.0,
            height: height,
            border: border ?? 8.0,
            onPressed: (isLoading) ? null : onPressed);

  final bool isLoading;

  final bool ignorePlatform;

  @override
  Widget build(BuildContext context) {
    if (!isLoading)
      return body(
          context: context,
          child: Txt(
            text,
            txtCase: txtCase,
            textStyle: textStyle,
            textSize: textSize,
            textColor: textColor,
          ));
    else
      return body(
          context: context,
          child: Center(
            child: CustomProgress(
              color: activeColor,
              ignorePlatform: ignorePlatform,
            ),
          ));
  }
}
