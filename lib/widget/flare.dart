import 'package:flutter/material.dart';
import 'package:holy_quran_app/animations/fader_animation.dart';

class Flare extends StatelessWidget {
  final Offset? offset;
  final Color? color;
  final double? top;
  final double? left;
  final double? right;
  final double? bottom;
  final double? height;
  final double? width;
  final Duration? flareDuration;
  const Flare(
      {Key? key,
      this.bottom,
      this.height,
      this.width,
      this.top,
      this.flareDuration,
      this.color,
      this.left,
      this.right,
      this.offset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: AnimatedFader(
        duraion: flareDuration,
        offset: offset,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
                   shape: BoxShape.circle,
              gradient: RadialGradient(colors: [
            color!,
            color!.withAlpha(150),
            color!.withAlpha(100),
            color!.withAlpha(50),
            color!.withAlpha(5),
          ])),
        ),
      ),
    );
  }
}
