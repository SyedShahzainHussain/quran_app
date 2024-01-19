import 'package:flutter/material.dart';
import 'package:holy_quran_app/animations/bottom_animation.dart';
import 'package:holy_quran_app/extension/media_query_extension.dart';

class AppButton extends StatelessWidget {
  final String? title;
  final Function()? onPressed;
  const AppButton({
    super.key,
    this.title,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      width: context.screenwidth * .7,
      height: context.screenheight * .05,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: const Color(0xffee8f8b),
        onPressed: onPressed,
        child: WidgetAnimation(
          child: Text(
            title!,
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
