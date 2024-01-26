import 'package:flutter/material.dart';
import 'package:holy_quran_app/animations/bottom_animation.dart';
import 'package:holy_quran_app/extension/media_query_extension.dart';
import 'package:holy_quran_app/provider/app_provider.dart';
import 'package:holy_quran_app/screens/juz_screen/view_model/juzz_view_model.dart';
import 'package:holy_quran_app/screens/juz_screen/widget/juz_text_widget.dart';
import 'package:holy_quran_app/utils/assets.dart';
import 'package:provider/provider.dart';

import '../../utils/routes/route_name.dart';
import '../../widget/flare.dart';

class JuzIndexScreen extends StatefulWidget {
  const JuzIndexScreen({super.key});

  @override
  State<JuzIndexScreen> createState() => _JuzIndexScreenState();
}

class _JuzIndexScreenState extends State<JuzIndexScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<JuzzViewModel>().clearSearchValue();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, _) => Scaffold(
        backgroundColor: appProvider.isDark ? Colors.grey[850] : Colors.white,
        body: SafeArea(
            child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Opacity(
                opacity: 0.3,
                child: Image.asset(
                  StaticAssets.quranRail,
                  height: context.screenheight * .17,
                ),
              ),
            ),
            Positioned(
              top: context.screenheight * .02,
              left: context.screenwidth * .02,
              child: const BackButton(),
            ),
            Positioned(
              top: context.screenheight * .12,
              left: context.screenwidth * .03,
              child: Text(
                "Juzz Index",
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: appProvider.isDark ? Colors.white : Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            JuzTextField(appProvider: appProvider),
            // ! for search number with juz
            Consumer<JuzzViewModel>(builder: (context, value, _) {
              return value.searchedJuzName.isNotEmpty
                  ? GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RouteName.juzPage,
                            arguments:
                                value.juzNames.indexOf(value.searchedJuzName) +
                                    1);
                      },
                      child: WidgetAnimation(
                        child: Container(
                          margin: EdgeInsets.only(
                            top: context.screenheight * 0.28,
                          ),
                          child: GestureDetector(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: Colors.white,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: appProvider.isDark
                                      ? Colors.grey[850]
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(15.0),
                                  border: Border.all(
                                    color: appProvider.isDark
                                        ? Colors.white
                                        : Colors.black38,
                                    width: 1,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      value.searchedJuzName,
                                      // style: AppText.h2b,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Consumer<JuzzViewModel>(
                      builder: (context, value, _) => Container(
                          margin: EdgeInsets.only(
                            top: context.screenheight * 0.28,
                          ),
                          child: GridView.builder(
                              keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3),
                              itemCount: value.juzNames.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, RouteName.juzPage,
                                        arguments: index + 1);
                                  },
                                  child: WidgetAnimation(
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      color: Colors.white,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: appProvider.isDark
                                              ? Colors.grey[850]
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          border: Border.all(
                                            color: appProvider.isDark
                                                ? Colors.white
                                                : Colors.black38,
                                            width: 1,
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "${index + 1}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium!
                                                  .copyWith(
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                            Text(
                                              context
                                                  .read<JuzzViewModel>()
                                                  .juzNames[index],
                                              // style: AppText.h2b,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              })),
                    );
            }),
            if (appProvider.isDark) ...[
              Flare(
                color: const Color(0xfff9e9b8),
                offset: Offset(context.screenwidth, -context.screenheight),
                bottom: -50,
                flareDuration: const Duration(seconds: 17),
                left: 100,
                height: 60,
                width: 60,
              ),
              Flare(
                color: const Color(0xfff9e9b8),
                offset: Offset(context.screenwidth, -context.screenheight),
                bottom: -50,
                flareDuration: const Duration(seconds: 17),
                left: 10,
                height: 40,
                width: 40,
              ),
              Flare(
                color: const Color(0xfff9e9b8),
                offset: Offset(context.screenwidth, -context.screenheight),
                bottom: -40,
                flareDuration: const Duration(seconds: 17),
                left: -100,
                height: 50,
                width: 50,
              ),
              Flare(
                color: const Color(0xfff9e9b8),
                offset: Offset(context.screenwidth, -context.screenheight),
                bottom: -20,
                flareDuration: const Duration(seconds: 17),
                left: -80,
                height: 20,
                width: 20,
              ),
              Flare(
                color: const Color(0xfff9e9b8),
                offset: Offset(context.screenwidth, -context.screenheight),
                bottom: -120,
                flareDuration: const Duration(seconds: 17),
                left: -80,
                height: 20,
                width: 20,
              ),
            ]
          ],
        )),
      ),
    );
  }
}
