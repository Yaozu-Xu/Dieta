import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FrostedGlass extends StatelessWidget {
  const FrostedGlass(
      {Key key,
      this.child,
      this.width,
      this.height,
      this.opacity,
      this.margin,
      this.innerChild,
      this.borderRadius})
      : super(key: key);

  final Widget child;
  final Widget innerChild;
  final double height;
  final double width;
  final double opacity;
  final EdgeInsets margin;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: margin,
        child: Stack(
          children: <Widget>[
            ClipRect(
              //背景过滤器
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
                child: Opacity(
                  opacity: opacity ?? 0.2,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: borderRadius),
                    constraints: BoxConstraints(
                      maxWidth: width ?? MediaQuery.of(context).size.width,
                      maxHeight: height,
                    ),
                    child: innerChild,
                  ),
                ),
              ),
            ),
            if (child != null) child
          ],
        ));
  }
}
