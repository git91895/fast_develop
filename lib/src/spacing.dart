import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../fast_develop.dart';

typedef Child = Widget Function();

class Spacing {
  static EdgeInsets rootLR({num size}) {
    var _size = size ?? SConfig.rootSpace;
    return leftAndRight(size: _size);
  }

  static EdgeInsets leftAndRight({num size, num right}) {
    var _size = size ?? SConfig.padding;
    var _right = right ?? _size;
    return EdgeInsets.only(left: _size.s, right: _right.s);
  }

  static EdgeInsets leftOrRight({num size, bool isLeft = true}) {
    var _size = size ?? SConfig.padding;
    var left = isLeft ? _size : 0;
    var right = !isLeft ? _size : 0;

    return EdgeInsets.only(left: left.s, right: right.s);
  }

  static EdgeInsets topAndBottom({num size, num bottom}) {
    var _size = size ?? SConfig.padding;
    var _bottom = bottom ?? _size;
    return EdgeInsets.only(top: _size.sh, bottom: _bottom.sh);
  }

  static EdgeInsets topOrBottom({num size, bool isTop = true}) {
    var _size = size ?? SConfig.padding;
    var top = isTop ? _size : 0;
    var bottom = !isTop ? _size : 0;

    return EdgeInsets.only(top: top.sh, bottom: bottom.sh);
  }

  static EdgeInsets all({num size, num leftR = -1, num topB = -1}) {
    var _size = size ?? SConfig.padding;

    if (leftR != -1 || topB != -1) _size = 0;
    var w = (leftR != -1 ? leftR : _size).s;
    var h = (topB != -1 ? topB : _size).s;
    return EdgeInsets.fromLTRB(w, h, w, h);
  }

  static EdgeInsets allNo({num leftR, num topB}) {
    leftR ??= SConfig.padding;
    topB ??= SConfig.listSpace;

    var w = leftR.s;
    var h = topB.sh;
    return EdgeInsets.fromLTRB(w, h, w, h);
  }

  static EdgeInsets fromLTRB(num left, num top, num right, num bottom) {
    return EdgeInsets.fromLTRB(left.s, top.s, right.s, bottom.s);
  }

  static Widget spaceList({num height}) {
    var _h = height ?? SConfig.listSpace;
    return spacingView(height: _h);
  }

  static Widget spacePadding({num size}) {
    var _size = size ?? SConfig.padding;
    return spacingView(height: _size, width: _size);
  }

  /// 用来做间距
  static Widget spacingView({num width, num height}) {
    var _w = width ?? SConfig.space;
    var _h = height ?? SConfig.space;
    return SizedBox(width: _w.s, height: _h.sh);
  }

  static Widget fillView({int flex = 1, Widget child}) {
    return Expanded(flex: flex, child: child ?? SizedBox());
  }

  /// [reverse] 反向使用[ValueNotifier]的值
  static Widget vView({
    Child child,
    ValueNotifier<bool> vn,
    bool isShow = false,
    bool noVLB,
    bool reverse = false,
  }) {
    if (isShow || (vn != null && vn.value)) {
      assert(child != null);
    }
    noVLB ??= vn == null;

    if (vn == null && !isShow) {
      return SizedBox();
    } else if (noVLB && isShow) {
      return child();
    }

    vn ??= ValueNotifier<bool>(isShow);
    return ValueListenableBuilder<bool>(
      valueListenable: vn,
      builder: (_, show, __) {
        var _show = reverse ? !show : show;
        return Visibility(visible: _show, child: _show ? child() : SizedBox());
      },
    );
  }

  static Widget wireView(
      {Color color = const Color(0xFFE2E2E2), num size = 2, bool isH = true}) {
    return Container(
        height: isH ? size.s : null, width: isH ? null : size.s, color: color);
  }

  static Widget wireView2(
      {Color color = const Color(0xFFE2E2E2), num w = 2, num h = 2}) {
    return Container(height: h.s, width: w.s, color: color);
  }

  /// 占位图片
  static Widget placeHolder({double width, double height}) {
    return SizedBox(
        width: width,
        height: height,
        child: CupertinoActivityIndicator(radius: min(10.0, width / 3)));
  }

  /// 失败图片
  static Widget error(
      {double width, double height, double size, IconData iconData}) {
    return SizedBox(
      width: width,
      height: height,
      child: Icon(iconData ?? Icons.error_outline, size: size),
    );
  }
}
