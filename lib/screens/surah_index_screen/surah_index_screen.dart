import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:holy_quran_app/animations/bottom_animation.dart';
import 'package:holy_quran_app/data/response/status.dart';
import 'package:holy_quran_app/extension/media_query_extension.dart';
import 'package:holy_quran_app/global/global.dart';
import 'package:holy_quran_app/provider/app_provider.dart';
import 'package:holy_quran_app/screens/surah_index_screen/widget/my_widget.dart';
// import 'package:holy_quran_app/screens/surah_index_screen/widget/surah_information_widget.dart';
import 'package:holy_quran_app/screens/surah_index_screen/widget/surah_text_widget.dart';
import 'package:holy_quran_app/utils/assets.dart';
// import 'package:holy_quran_app/utils/routes/route_name.dart';
import 'package:provider/provider.dart';

import '../../utils/routes/route_name.dart';
import '../../widget/flare.dart';
import 'viewModel/surah_view_model.dart';
import 'widget/surah_information_widget.dart';

class SurahIndexScreen extends StatefulWidget {
  const SurahIndexScreen({super.key});

  @override
  State<SurahIndexScreen> createState() => _SurahIndexScreenState();
}

class _SurahIndexScreenState extends State<SurahIndexScreen> {
  SurahViewModel surahViewModel = SurahViewModel();
  SurahViewModel surahViewModel2 = SurahViewModel();

  @override
  void initState() {
    super.initState();
    getLocalData();
  }

  // * if there is no data base of this name then this method will call
  Future getLocalData() async {
    cache.get("surahs") ?? surahViewModel.getSurah();
    cache.get("surahs") ?? surahViewModel2.surahsApi();

    if (cache.get("surahs") != null) {
      context.read<SurahViewModel>().chapterHive();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appPovider, _) => Scaffold(
        backgroundColor: appPovider.isDark ? Colors.grey[850] : Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Opacity(
                    opacity: 0.3,
                    child: Image.asset(
                      StaticAssets.kaba,
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
                top: context.screenheight * .12,
                left: context.screenwidth * .03,
                child: Text(
                  "Surah Index",
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: appPovider.isDark ? Colors.white : Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              SurahTextField(appProvider: appPovider),
              cache.get("surahs") == null
                  ? ChangeNotifierProvider(
                      create: (context) => surahViewModel,
                      child: Consumer<SurahViewModel>(
                          builder: (context, value, _) {
                        switch (value.surahList.status) {
                          case Status.LOADING:
                            return const LinearProgressIndicator(
                              backgroundColor: Color(0xffee8f8b),
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            );
                          case Status.COMPLETED:
                            return MyWidget(
                              itemCount:
                                  value.surahList.data!.data!.surahs!.length,
                              appProvider: appPovider,
                              value: value,
                            );
                          default:
                            return const SizedBox.shrink();
                        }
                      }),
                    )
                  : Consumer<SurahViewModel>(builder: (context, value, _) {
                      switch (value.dataList.status) {
                        case Status.COMPLETED:
                          return Container(
                            margin: EdgeInsets.only(
                                top: context.screenheight * .28),
                            child: ListView.separated(
                              keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                              itemCount: value.dataList.data!.surahs!.length,
                              separatorBuilder: (context, index) =>
                                  const Divider(
                                color: Color(0xffee8f8b),
                              ),
                              itemBuilder: (context, index) {
                                final chapters = value.dataList.data!.surahs!;
                                return InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      RouteName.page2,
                                      arguments: chapters[index],
                                    );
                                  },
                                  onLongPress: () => showDialog(
                                    context: context,
                                    builder: (context) => SurahInformation(
                                      surahModel: null,
                                      hiveSurah: chapters[index],
                                      appProvider: appPovider,
                                    ),
                                  ),
                                  child: WidgetAnimation(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(chapters[index]!
                                              .number
                                              .toString()),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                chapters[index]!
                                                    .englishName
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Text(
                                                chapters[index]!
                                                    .englishNameTranslation
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Expanded(
                                            child: Text(
                                              chapters[index]!.name.toString(),
                                              // style: AppText.b1b,
                                              textAlign: TextAlign.right,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        default:
                          return const SizedBox.shrink();
                      }
                    }),
              if (appPovider.isDark) ...[
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
          ),
        ),
      ),
    );
  }
}
