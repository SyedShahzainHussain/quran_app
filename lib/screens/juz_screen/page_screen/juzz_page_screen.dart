import 'package:flutter/material.dart';
import 'package:holy_quran_app/data/response/status.dart';
import 'package:holy_quran_app/extension/media_query_extension.dart';
import 'package:holy_quran_app/global/global.dart';
import 'package:holy_quran_app/provider/app_provider.dart';
import 'package:holy_quran_app/screens/juz_screen/view_model/juzz_view_model.dart';
import 'package:holy_quran_app/utils/assets.dart';
import 'package:holy_quran_app/model/juzz/juzz.dart' as ju;

import 'package:provider/provider.dart';

import '../../../animations/bottom_animation.dart';

class JuzzPageScreen extends StatefulWidget {
  final int? juzzIndex;
  const JuzzPageScreen({super.key, this.juzzIndex});

  @override
  State<JuzzPageScreen> createState() => _JuzzPageScreenState();
}

class _JuzzPageScreenState extends State<JuzzPageScreen> {
  JuzzViewModel juzzViewModel = JuzzViewModel();
  JuzzViewModel juzzViewModel2 = JuzzViewModel();

  @override
  void initState() {
    super.initState();
    // ! if cache is null then get data from server
    cache.get("juz${widget.juzzIndex}") ??
        juzzViewModel.getJuzz(widget.juzzIndex!);
    // ! if cache is null then  get data from local database
    cache.get("juz${widget.juzzIndex}") ??
        juzzViewModel.juzzApi(widget.juzzIndex!);
    juzzViewModel2.juzzHive(widget.juzzIndex!);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
        builder: (context, appProvider, _) => Scaffold(
              backgroundColor:
                  appProvider.isDark ? Colors.grey[900] : Colors.white,
              body: cache.get("juz${widget.juzzIndex}") == null
                  ? ChangeNotifierProvider(
                      create: (context) => juzzViewModel,
                      child:
                          Consumer<JuzzViewModel>(builder: (context, valu, _) {
                        switch (valu.apiResponse.status) {
                          case Status.LOADING:
                            return const Scaffold(
                              body: SafeArea(
                                child: LinearProgressIndicator(
                                  backgroundColor: Color(0xffee8f8b),
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.white),
                                ),
                              ),
                            );
                          case Status.ERROR:
                            return Center(
                              child: Text(valu.apiResponse.message!),
                            );
                          case Status.COMPLETED:
                            return SafeArea(
                              top: false,
                              child: CustomScrollView(
                                slivers: [
                                  SliverAppBar(
                                    leading: BackButton(
                                      color: appProvider.isDark
                                          ? Colors.white
                                          : Colors.black54,
                                    ),
                                    backgroundColor: appProvider.isDark
                                        ? Colors.grey[850]
                                        : Colors.white,
                                    pinned: true,
                                    expandedHeight: context.screenheight * 0.27,
                                    flexibleSpace: FlexibleSpaceBar(
                                      centerTitle: true,
                                      title: Text(
                                        widget.juzzIndex.toString(),
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
                                                height:
                                                    context.screenheight / 5,
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                const Text(
                                                  'بِسْمِ ٱللَّٰهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ',
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  valu.juzNames[
                                                      (widget.juzzIndex! - 1)],
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
                                    childCount: valu
                                        .apiResponse.data!.data!.ayahs!.length,
                                    (context, index) => WidgetAnimation(
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: ListTile(
                                          contentPadding:
                                              const EdgeInsets.all(8.0),
                                          trailing: CircleAvatar(
                                            radius: 13.9,
                                            backgroundColor:
                                                const Color(0xff04364f),
                                            child: CircleAvatar(
                                              radius: 10.9,
                                              backgroundColor: Colors.white,
                                              child: FittedBox(
                                                child: Text(
                                                  "${(valu.apiResponse.data!.data!.ayahs![index].number)}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelSmall!
                                                      .copyWith(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                          title: Text(
                                            valu.apiResponse.data!.data!
                                                .ayahs![index].text!,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              fontFamily: 'Noor',
                                              fontSize:
                                                  context.screenheight * 0.0275,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ))
                                ],
                              ),
                            );
                          default:
                            return const SizedBox.shrink();
                        }
                      }),
                    )
                  : ChangeNotifierProvider(
                      create: (context) => juzzViewModel2,
                      child:
                          Consumer<JuzzViewModel>(builder: (context, valu, _) {
                        switch (valu.localResponse.status) {
                          case Status.COMPLETED:
                            return SafeArea(
                              top: false,
                              child: CustomScrollView(
                                slivers: [
                                  SliverAppBar(
                                    leading: BackButton(
                                      color: appProvider.isDark
                                          ? Colors.white
                                          : Colors.black54,
                                    ),
                                    backgroundColor: appProvider.isDark
                                        ? Colors.grey[850]
                                        : Colors.white,
                                    pinned: true,
                                    expandedHeight: context.screenheight * 0.27,
                                    flexibleSpace: FlexibleSpaceBar(
                                      centerTitle: true,
                                      title: Text(
                                        widget.juzzIndex.toString(),
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
                                                height:
                                                    context.screenheight / 5,
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                const Text(
                                                  'بِسْمِ ٱللَّٰهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ',
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  valu.juzNames[
                                                      (widget.juzzIndex! - 1)],
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
                                    childCount:
                                        valu.localResponse.data!.ayahs!.length,
                                    (context, index) => WidgetAnimation(
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: ListTile(
                                          contentPadding:
                                              const EdgeInsets.all(8.0),
                                          trailing: CircleAvatar(
                                            radius: 13.9,
                                            backgroundColor:
                                                const Color(0xff04364f),
                                            child: CircleAvatar(
                                              radius: 10.9,
                                              backgroundColor: Colors.white,
                                              child: FittedBox(
                                                child: Text(
                                                  "${(valu.localResponse.data!.ayahs![index]!.number)}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelSmall!
                                                      .copyWith(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                          title: Text(
                                            valu.localResponse.data!
                                                .ayahs![index]!.text!,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              fontFamily: 'Noor',
                                              fontSize:
                                                  context.screenheight * 0.0275,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ))
                                ],
                              ),
                            );
                          default:
                            return const SizedBox.shrink();
                        }
                      }),
                    ),
            ));
  }
}
