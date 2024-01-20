
import 'package:flutter/material.dart';
import 'package:holy_quran_app/extension/media_query_extension.dart';

class AppName extends StatelessWidget {
  const AppName({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: context.screenheight * 0.12,
      left: context.screenwidth * 0.05,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "The",
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: Colors.grey),
          ),
          Text(
            "Holy\nQur'an",
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Colors.grey,
                  height: 1.3,
                  fontWeight: FontWeight.w600,
                ),
          )
        ],
      ),
    );
  }
}
