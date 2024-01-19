
import 'package:flutter/widgets.dart';
import 'package:holy_quran_app/extension/media_query_extension.dart';
import 'package:holy_quran_app/utils/assets.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: context.screenheight * 0.045,
        right: context.screenwidth * 0.01,
        child: Image.asset(
          StaticAssets.gradLogo,
          height: context.screenheight / 4,
        ));
  }
}