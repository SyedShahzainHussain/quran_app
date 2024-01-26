import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:holy_quran_app/extension/media_query_extension.dart';


import 'package:holy_quran_app/provider/app_provider.dart';
import 'package:holy_quran_app/screens/home/widget/app/custom_drawer.dart';
import 'package:holy_quran_app/screens/home/widget/main_screen/main_screen.dart';

import 'package:provider/provider.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
 

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

 
   
  }

  

  late bool _canBeDragged;

  void _onDragStart(DragStartDetails dragStartDetails) {
    bool isDragOpenFromLeft = animationController.isDismissed;
    bool isDragOpenFromRight = animationController.isCompleted;
    _canBeDragged = isDragOpenFromLeft || isDragOpenFromRight;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta = details.primaryDelta! / context.screenwidth * 0.835;
      animationController.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    double kMinFlingVelocity = 365.0;

    if (animationController.isDismissed || animationController.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= kMinFlingVelocity) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;

      animationController.fling(velocity: visualVelocity);
    } else if (animationController.value < 0.5) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
  }

  void toggle() => animationController.isDismissed
      ? animationController.forward()
      : animationController.reverse();

  Future<bool> _onWillPop() async {
    return (await (showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            title: const Text(
              "Exit Application",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Text(
              "Are You Sure?",
              style: Theme.of(context).textTheme.labelMedium,
            ),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  "Yes",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  SystemNavigator.pop();
                },
              ),
              TextButton(
                child: const Text(
                  "No",
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ) as Future<bool>?)) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Material(
        color: appProvider.isDark ? Colors.grey[800] : Colors.white,
        child: GestureDetector(
          onHorizontalDragStart: _onDragStart,
          onHorizontalDragUpdate: _onDragUpdate,
          onHorizontalDragEnd: _onDragEnd,
          child: AnimatedBuilder(
              animation: animationController,
              builder: (context, _) {
                return Stack(
                  children: [
                    Transform.translate(
                      offset: Offset(
                          context.screenwidth *
                              0.835 *
                              (animationController.value - 1),
                          0),
                      child: Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..setRotationY(
                              pi / 2 * (1 - animationController.value)),
                        alignment: Alignment.centerRight,
                        child: const CustomDrawer(),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(
                          context.screenwidth *
                              .835 *
                              animationController.value,
                          0),
                      child: Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..setRotationY(pi / 2 * animationController.value),
                        alignment: Alignment.centerLeft,
                        child: const MainScreen(),
                      ),
                    ),
                    Positioned(
                      top: 4.0 + MediaQuery.of(context).padding.top,
                      left: context.screenwidth * .01 +
                          animationController.value *
                              context.screenwidth *
                              .835,
                      child: IconButton(
                        icon: const Icon(
                          Icons.menu,
                        ),
                        onPressed: toggle,
                        color: appProvider.isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
