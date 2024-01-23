import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:holy_quran_app/data/response/status.dart';
import 'package:holy_quran_app/extension/media_query_extension.dart';
import 'package:holy_quran_app/model/surahs.dart';
import 'package:holy_quran_app/provider/app_provider.dart';
import 'package:holy_quran_app/screens/surah_index_screen/widget/my_widget.dart';
import 'package:holy_quran_app/screens/surah_index_screen/widget/surah_information_widget.dart';
import 'package:holy_quran_app/screens/surah_index_screen/widget/surah_text_widget.dart';
import 'package:holy_quran_app/utils/assets.dart';
import 'package:holy_quran_app/utils/routes/route_name.dart';
import 'package:provider/provider.dart';

import 'viewModel/surah_view_model.dart';

class SurahIndexScreen extends StatefulWidget {
  const SurahIndexScreen({super.key});

  @override
  State<SurahIndexScreen> createState() => _SurahIndexScreenState();
}

class _SurahIndexScreenState extends State<SurahIndexScreen> {
  SurahViewModel surahViewModel = SurahViewModel();
  final cache = Hive.box('data');

  @override
  void initState() {
    super.initState();
    getLocalData();
  }

  // * if there is no data base of this name then this method will call
  Future getLocalData() async {
    // ignore: use_build_context_synchronously
    cache.get("surahs") ?? surahViewModel.getSurah();
    cache.get("surahs") ?? context.read<SurahViewModel>().surahsApi();
    if (cache.get("surahs") != null) {
      context.read<SurahViewModel>().chapterHive();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => surahViewModel,
      child: Consumer<AppProvider>(
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
                    ? Consumer<SurahViewModel>(builder: (context, value, _) {
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
                      })
                    : FutureBuilder(
                        future: context.read<SurahViewModel>().chapterHive(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const LinearProgressIndicator(
                              backgroundColor: Color(0xffee8f8b),
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            );
                          } else if (snapshot.hasError) {
                            return Text("Error: ${snapshot.error}");
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Text("No cached data available");
                          } else {
                            final List chapters =
                                context.watch<SurahViewModel>().surahHiveList;

                            return Container(
                              margin: EdgeInsets.only(
                                  top: context.screenheight * .28),
                              child: ListView.separated(
                                keyboardDismissBehavior:
                                    ScrollViewKeyboardDismissBehavior.onDrag,
                                itemCount: chapters.length,
                                separatorBuilder: (context, index) =>
                                    const Divider(
                                  color: Color(0xffee8f8b),
                                ),
                                itemBuilder: (context, index) {
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
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(chapters[index]
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
                                                chapters[index]
                                                    .englishName
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Text(
                                                chapters[index]
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
                                              chapters[index].name.toString(),
                                              // style: AppText.b1b,
                                              textAlign: TextAlign.right,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                        })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
