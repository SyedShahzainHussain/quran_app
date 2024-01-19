
import 'package:flutter/material.dart';
import 'package:holy_quran_app/extension/media_query_extension.dart';
import 'package:holy_quran_app/utils/assets.dart';

class Rahel extends StatelessWidget {
  const Rahel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: context.screenwidth * 0.0,
        bottom: context.screenheight * 0.0,
        child: Opacity(
          opacity: 0.25,
          child: Image.asset(
            StaticAssets.quranRail,
          ),
        ));
  }
}

