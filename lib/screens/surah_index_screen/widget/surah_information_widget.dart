import 'package:flutter/material.dart';
import 'package:holy_quran_app/extension/media_query_extension.dart';
import 'package:holy_quran_app/model/surah/surah_model.dart';
import 'package:holy_quran_app/model/surah/surahs.dart' as hive_surah;
import 'package:holy_quran_app/provider/app_provider.dart';

// import '../../../model/surah_model.dart';

class SurahInformation extends StatefulWidget {
  const SurahInformation(
      {super.key, this.surahModel, this.hiveSurah, required this.appProvider});

  final Surahs? surahModel;
  final hive_surah.Surahs? hiveSurah;
  final AppProvider appProvider;

  @override
  State<SurahInformation> createState() => _SurahInformationState();
}

class _SurahInformationState extends State<SurahInformation>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> scaleAnimation;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      animationController,
    );

    animationController.forward();
  }

  @override
  void dispose() {
    if (animationController.isAnimating) {
      animationController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final surahModel = widget.surahModel;
    final hiveSurah = widget.hiveSurah;
    return ScaleTransition(
      scale: scaleAnimation,
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
            width: context.screenwidth * .75,
            height: context.screenheight * .37,
            decoration: ShapeDecoration(
              color:
                  widget.appProvider.isDark ? Colors.grey[850] : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Surah Information',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: context.screenheight * 0.03,
                    ),
                  ),
                  SizedBox(
                    height: context.screenheight * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        surahModel?.englishName ?? hiveSurah!.englishName!,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        surahModel?.name ?? hiveSurah!.name!,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  Text(
                      "Ayahs: ${surahModel?.ayahs?.length ?? hiveSurah!.ayahs!.length}"),
                  Text(
                      "Surah Number: ${surahModel?.number ?? hiveSurah!.number}"),
                  Text(
                      "Revelation: ${surahModel?.revelationType ?? hiveSurah!.revelationType}"),
                  Text(
                      "Meaning: ${surahModel?.englishNameTranslation ?? hiveSurah!.englishNameTranslation}"),
                  SizedBox(
                    height: context.screenheight * 0.02,
                  ),
                  SizedBox(
                    height: context.screenheight * 0.05,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xffee8f8b)),
                      ),
                      onPressed: () => {
                        if (animationController.isCompleted)
                          {
                            animationController.reverse(),
                          },
                        Navigator.pop(context),
                      },
                      child: const Text("OK"),
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
