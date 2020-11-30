import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

enum TxtCase { LowerCase, UpperCase, None }

class Rich {
  final TextStyle style;
  final String key;
  final ValueChanged<String> onRichTap;

  Rich({this.style, @required this.key, this.onRichTap}) {
    assert(key != null);
    assert(style != null);
  }
}

class Txt extends StatelessWidget {
  final Color color;
  final double size;
  final FontWeight fontWeight;
  final String font;
  final String value;
  final TxtCase txtCase;
  final int maxLine;
  final Rich rich;
  final TextAlign align;
  final TextOverflow over;
  final TextStyle style;
  final TextDecoration decoration;

  Txt(this.value,
      {this.color,
      this.size,
      this.fontWeight,
      this.font,
      this.txtCase = TxtCase.None,
      this.maxLine = 0,
      this.align,
      this.rich,
      this.decoration = TextDecoration.none,
      this.style,
      this.over}) {
    assert(value != null);
    assert(txtCase != null);
  }

  _Text() {
    if (txtCase == TxtCase.LowerCase) {
      return value.toLowerCase();
    }

    if (txtCase == TxtCase.UpperCase) {
      return value.toUpperCase();
    }

    return value;
  }



  List<TextSpan> _getSpans(String text) {
    List<TextSpan> spans = [];
    try {
      int spanBoundary = 0;

      do {
        final startIndex = text.indexOf(rich.key, spanBoundary);
        if (startIndex == -1) {
          spans.add(
              TextSpan(style: _getStyle, text: text.substring(spanBoundary)));
          return spans;
        }
        if (startIndex > spanBoundary) {
          spans.add(TextSpan(
              style: _getStyle,
              text: text.substring(spanBoundary, startIndex)));
        }
        final endIndex = startIndex + rich.key.length;
        final spanText = text.substring(startIndex, endIndex);
        spans.add(TextSpan(
            text: spanText,
            style: rich.style,
            recognizer: _onRichTap(spanText)));
        spanBoundary = endIndex;
      } while (spanBoundary < text.length);
    } catch (error) {
      print(error.toString());
    }
    return spans;
  }

  TapGestureRecognizer _onRichTap(String value) {
    if (rich.onRichTap == null) return null;
    return TapGestureRecognizer()..onTap = () => rich.onRichTap(value);
  }

  _bodyRichText() {
    var text = _Text();
    var spans = _getSpans(text);
    return Text.rich(
      TextSpan(style: _getStyle, children: spans),
      textAlign: align,
    );
  }

  _bodyDefaultText() {
    var text = _Text();
    return Text(
      '${text}',
      maxLines: maxLine == 0 ? null : maxLine,
      overflow: over,
      textAlign: align,
      style: _getStyle,
    );
  }

  TextStyle get _getStyle =>
      style ??
      TextStyle(
          fontFamily: font,
          fontSize: size ?? 16,
          color: color,
          fontWeight: fontWeight);

  @override
  Widget build(BuildContext context) {
    if (rich == null) return _bodyDefaultText();
    return _bodyRichText();
  }
}
