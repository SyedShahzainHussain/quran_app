import 'package:flutter/material.dart';
import 'package:holy_quran_app/extension/media_query_extension.dart';
import 'package:holy_quran_app/provider/app_provider.dart';
import 'package:provider/provider.dart';

class OnBoardingPage extends StatelessWidget {
  final String image;
  final String text;
  const OnBoardingPage({
    Key? key,
    required this.image,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Spacer(),
          Image.asset(
            image,
            height: context.screenheight * .5,
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: context.read<AppProvider>().isDark
                          ? Colors.white
                          : Colors.black),
                ),
              ),
              const Spacer(),
            ],
          ),
          SizedBox(height: context.screenheight * .05)
        ],
      ),
    );
  }
}
