import 'package:flutter/material.dart';
import 'package:holy_quran_app/extension/media_query_extension.dart';
import 'package:holy_quran_app/provider/app_provider.dart';
import 'package:holy_quran_app/screens/bookmarks/viewModel/bookmark_view_model.dart';
import 'package:holy_quran_app/screens/bookmarks/widget/surah_widget.dart';
import 'package:holy_quran_app/screens/surah_index_screen/widget/my_widget.dart';
import 'package:holy_quran_app/utils/assets.dart';
import 'package:provider/provider.dart';

class BookMarkScreen extends StatelessWidget {
  const BookMarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, _) => Scaffold(
        backgroundColor: appProvider.isDark ? Colors.grey[850] : Colors.white,
        body: SafeArea(
            child: Stack(
          fit: StackFit.expand,
          children: [
            if (!appProvider.isDark)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Opacity(
                    opacity: 0.3,
                    child: Image.asset(
                      StaticAssets.sajda,
                      height: context.screenheight * .17,
                    ),
                  ),
                ),
              ),
            Positioned(
              top: context.screenheight * .02,
              left: context.screenwidth * .02,
              child: const BackButton(),
            ),
            Positioned(
              top: context.screenheight * .08,
              left: context.screenwidth * .03,
              child: Text(
                "Bookmarks",
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: appProvider.isDark ? Colors.white : Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            Consumer<BookMarkViewModel>(
              builder: (context, value, _) => value.bookmarks.isEmpty
                  ? Center(
                      child: Text(
                        "No Bookmark Added!",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: appProvider.isDark
                                  ? Colors.white
                                  : Colors.grey,
                            ),
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(top: context.screenheight * .22),
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return SurahWidgetforLocal(
                            appProvider: appProvider,
                            surahs: value.bookmarks[index],
                          );
                        },
                        itemCount: value.bookmarks.length,
                      ),
                    ),
            )
          ],
        )),
      ),
    );
  }
}
