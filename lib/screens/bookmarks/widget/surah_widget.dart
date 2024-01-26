import 'package:flutter/material.dart';
import 'package:holy_quran_app/model/surah/surahs.dart';
import 'package:holy_quran_app/provider/app_provider.dart';
import 'package:holy_quran_app/screens/surah_index_screen/widget/surah_information_widget.dart';
import 'package:holy_quran_app/utils/routes/route_name.dart';

import '../../../animations/bottom_animation.dart';

class SurahWidgetforLocal extends StatelessWidget {
  final Surahs? surahs;
  final AppProvider? appProvider;
  const SurahWidgetforLocal({super.key, this.surahs, this.appProvider});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          RouteName.page2,
          arguments: surahs,
        );
      },
      onLongPress: () => showDialog(
        context: context,
        builder: (context) => SurahInformation(
          surahModel: null,
          hiveSurah: surahs,
          appProvider: appProvider!,
        ),
      ),
      child: WidgetAnimation(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(surahs!.number.toString()),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    surahs!.englishName.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    surahs!.englishNameTranslation.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Text(
                  surahs!.name.toString(),
                  // style: AppText.b1b,
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
