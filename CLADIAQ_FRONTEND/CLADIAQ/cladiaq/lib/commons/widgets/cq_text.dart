import 'package:cladiaq/commons/colors.dart';
import 'package:cladiaq/commons/styles.dart';
import 'package:flutter/material.dart';

class CqText extends StatelessWidget {
  final String text;
  final TextStyle style;

  const CqText.heading1(this.text, {Key? key})
      : style = heading1Style,
        super(key: key);
  const CqText.heading2(this.text, {Key? key})
      : style = heading2Style,
        super(key: key);
  const CqText.heading3(this.text, {Key? key})
      : style = heading3Style,
        super(key: key);
  const CqText.subHeading(this.text, {Key? key})
      : style = subHeadingStyle,
        super(key: key);
  const CqText.headline(this.text, {Key? key})
      : style = headlineStyle,
        super(key: key);

  const CqText.caption(this.text, {Key? key})
      : style = captionStyle,
        super(key: key);

  CqText.body(this.text, {Key? key, Color color = cqMediumGreyColor})
      : style = bodyStyle.copyWith(color: color),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
    );
  }
}
