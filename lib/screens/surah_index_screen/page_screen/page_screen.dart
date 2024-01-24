import 'package:flutter/material.dart';
import 'package:holy_quran_app/animations/bottom_animation.dart';
import 'package:holy_quran_app/extension/media_query_extension.dart';
import 'package:holy_quran_app/model/surah/surah_model.dart';
import 'package:holy_quran_app/provider/app_provider.dart';
import 'package:holy_quran_app/utils/assets.dart';
import 'package:provider/provider.dart';

class PageScreen extends StatelessWidget {
  final Surahs? surahs;
  const PageScreen({super.key, this.surahs});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, _) => Scaffold(
        backgroundColor: appProvider.isDark ? Colors.grey[900] : Colors.white,
        body: SafeArea(
          top: false,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                actions: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.bookmark_added,
                        color:
                            appProvider.isDark ? Colors.white : Colors.black54,
                      ))
                ],
                leading: BackButton(
                  color: appProvider.isDark ? Colors.white : Colors.black54,
                ),
                backgroundColor:
                    appProvider.isDark ? Colors.grey[850] : Colors.white,
                pinned: true,
                expandedHeight: context.screenheight * 0.27,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    surahs!.englishName!,
                    textAlign: TextAlign.center,
                  ),
                  background: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Opacity(
                          opacity: 0.3,
                          child: Image.asset(
                            StaticAssets.quranRail,
                            height: context.screenheight / 5,
                          ),
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              surahs!.englishNameTranslation!,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              surahs!.name!,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .copyWith(
                                    fontFamily: 'Noor',
                                    height: 1.5,
                                  ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                childCount: surahs!.ayahs!.length,
                (context, index) => WidgetAnimation(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(8.0),
                      trailing: CircleAvatar(
                        radius: 13.9,
                        backgroundColor: const Color(0xff04364f),
                        child: CircleAvatar(
                          radius: 10.9,
                          backgroundColor: Colors.white,
                          child: FittedBox(
                            child: Text(
                              "${(index + 1)}",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        surahs!.ayahs![index].text!,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontFamily: 'Noor',
                          fontSize: context.screenheight * 0.0275,
                        ),
                      ),
                    ),
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
