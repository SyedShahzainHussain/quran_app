import 'package:flutter/material.dart';

class AnimatedFader extends StatefulWidget {
  final Widget? child;
  final Duration delay;
  final Duration? duraion;
  final Offset? offset;

  const AnimatedFader({
    super.key,
    this.child,
    this.delay = const Duration(milliseconds: 0),
    this.duraion = const Duration(milliseconds: 100),
    this.offset = const Offset(0.0, 22.0),
  });

  @override
  State<AnimatedFader> createState() => _AnimatedFaderState();
}

class _AnimatedFaderState extends State<AnimatedFader>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation _dxAnimation;
  late Animation _dyAnimation;
  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: widget.duraion);
    _dxAnimation =
        Tween(begin: widget.offset!.dx, end: 0.0).animate(animationController);
    _dyAnimation =
        Tween(begin: widget.offset!.dy, end: 0.0).animate(animationController);

    Future.delayed(widget.delay, () {
      animationController.repeat();
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Opacity(
            opacity: animationController.value,
            child: Transform.translate(
              offset: Offset(_dxAnimation.value, _dyAnimation.value),
              child: widget.child,
            ),
          );
        });
  }
}
