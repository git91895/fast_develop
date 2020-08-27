import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../fast_develop.dart';

class DecoUtil {
  static BoxDecoration img({
    double radius = 20,
    bool isCircle = false,
    bool isAsset = true,
    @required String url,
  }) {
    return normal(
      color: null,
      isCircle: isCircle,
      radius: radius,
      image: isAsset ? AssetImage(url) : NetworkImage(url),
    );
  }

  static BoxDecoration normal({
    Color color,
    double radius = 20,
    bool isCircle = false,
    ImageProvider image,
    Border border,
    Gradient gradient,
  }) {
    return BoxDecoration(
      color: gradient != null ? null : (color ?? CConfig.cBackgroundColor),
      border: border,
      borderRadius: isCircle
          ? SBorderRadius.leftRight()
          : SBorderRadius.normal(radius: radius),
      image: image == null ? null : DecorationImage(image: image),
      gradient: gradient,
    );
  }

  static BoxDecoration different({
    Color color = Colors.white,
    double radius1 = 20,
    double radius2 = 90,
    bool isV = true,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: isV
          ? SBorderRadius.only(
              topLeft: radius1,
              topRight: radius1,
              bottomLeft: radius2,
              bottomRight: radius2)
          : SBorderRadius.only(
              topLeft: radius1,
              bottomLeft: radius1,
              topRight: radius2,
              bottomRight: radius2),
    );
  }

  static BoxDecoration grey(
      {Color color, double radius = 20, bool isCircle = false}) {
    return normal(
        color: color ?? CConfig.grey, radius: radius, isCircle: isCircle);
  }

  static BoxDecoration white(
      {Color color, double radius = 20, bool isCircle = false}) {
    return normal(
        color: color ?? CConfig.white, radius: radius, isCircle: isCircle);
  }

  static BoxDecoration red(
      {Color color, double radius = 20, bool isCircle = false}) {
    return BoxDecoration(
        color: color ?? CConfig.redBright,
        borderRadius: isCircle
            ? SBorderRadius.leftRight()
            : SBorderRadius.normal(radius: radius));
  }

  static BoxDecoration primary(
      {Color color, double radius = 20, bool isCircle = false}) {
    return BoxDecoration(
        color: color ?? CConfig.primaryColor,
        borderRadius: isCircle
            ? SBorderRadius.leftRight()
            : SBorderRadius.normal(radius: radius));
  }

  static BoxDecoration radius(
      {Color color, BorderRadiusGeometry radius, bool isCircle = false}) {
    return BoxDecoration(
        color: color ?? CConfig.cBackgroundColor, borderRadius: radius);
  }

  /// 0 - 3 leftOrTopOrRightOrBottom
  static BoxDecoration unilateral(int leftOrTopOrRightOrBottom,
      {Color color, double radius = 20, bool isCircle = false}) {
    var borderRadius;
    var _radius = isCircle ? 200 : radius;
    switch (leftOrTopOrRightOrBottom) {
      case 0:
        borderRadius = SBorderRadius.leftOrRight(radius: _radius);
        break;
      case 1:
        borderRadius = SBorderRadius.topOrButton(radius: _radius);
        break;
      case 2:
        borderRadius =
            SBorderRadius.leftOrRight(radius: _radius, isLeft: false);
        break;
      case 3:
        borderRadius = SBorderRadius.topOrButton(radius: _radius, isTop: false);
        break;
    }

    return BoxDecoration(
      color: color ?? CConfig.cBackgroundColor,
      borderRadius: borderRadius,
    );
  }

  /// 0 - 3 [topLeft]-[rightTop]-[rightBottom]-[leftBottom] 单
  static BoxDecoration only(int leftOrTopOrRightOrBottom,
      {Color color = Colors.white, double radius = 20, BoxBorder border}) {
    var topLeft = Radius.zero;
    var topRight = Radius.zero;
    var bottomRight = Radius.zero;
    var bottomLeft = Radius.zero;
    switch (leftOrTopOrRightOrBottom) {
      case 0:
        topLeft = Radius.circular(radius.s);
        break;
      case 1:
        topRight = Radius.circular(radius.s);
        break;
      case 2:
        bottomRight = Radius.circular(radius.s);
        break;
      case 3:
        bottomLeft = Radius.circular(radius.s);
        break;
    }

    return BoxDecoration(
      color: color,
      border: border,
      borderRadius: BorderRadius.only(
        topLeft: topLeft,
        topRight: topRight,
        bottomLeft: bottomLeft,
        bottomRight: bottomRight,
      ),
    );
  }

  static BoxDecoration border(
      {Color color,
      Color borderColor = Colors.black,
      double radius = 20,
      bool isCircle = false}) {
    return BoxDecoration(
        color: CConfig.getBackground(color: color),
        border: Border.all(color: CConfig.getMatching(color: borderColor)),
        borderRadius: isCircle
            ? SBorderRadius.leftRight()
            : SBorderRadius.normal(radius: radius));
  }

  static BoxDecoration borderUnilateral(
    int leftOrTopOrRightOrBottom, {
    Color color,
    Color borderColor = Colors.black,
    double radius = 20,
    bool isCircle = false,
    BorderStyle style = BorderStyle.solid,
    bool reverse = false,
  }) {
    BorderSide side = BorderSide(color: borderColor, width: 1.0, style: style);

    var left;
    var top;
    var right;
    var bottom;
    if (reverse) {
      left = side;
      top = side;
      right = side;
      bottom = side;
      side = BorderSide.none;
    } else {
      left = BorderSide.none;
      top = BorderSide.none;
      right = BorderSide.none;
      bottom = BorderSide.none;
    }
    switch (leftOrTopOrRightOrBottom) {
      case 0:
        left = side;
        break;
      case 1:
        top = side;
        break;
      case 2:
        right = side;
        break;
      case 3:
        bottom = side;
        break;
    }

    return BoxDecoration(
      color: color ?? CConfig.cBackgroundColor,
      border: Border(left: left, top: top, right: right, bottom: bottom),
    );
  }
}