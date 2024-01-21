import 'package:flutter/material.dart';
import 'package:holy_quran_app/extension/media_query_extension.dart';
import 'package:holy_quran_app/utils/assets.dart';

import 'widget/share_button_widget.dart';

class ShareScreen extends StatelessWidget {
  const ShareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: context.screenheight * .13,
              ),
              Image.asset(
                StaticAssets.gradLogo,
                height: context.screenheight * .2,
              ),
              SizedBox(
                height: context.screenheight * 0.02,
              ),
              Text(
                "The Holy Qur'an App is also available as Open Source on GitHub!",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(
                height: context.screenheight * 0.05,
              ),
              ShareButton(
                iconData: Icons.share,
                title: "Share App",
                onPressed: () {},
              ),
              ShareButton(
                iconData: const IconData(
                  0xf09b,
                  fontFamily: _kFontFam,
                ),
                title: "Github Repo",
                onPressed: () {},
              ),
              SizedBox(height: context.screenheight * 0.02),
            ],
          ),
        ),
      ),
    );
  }

  static const _kFontFam = 'ShareIcon';

}
