
import 'package:flutter/material.dart';
import 'package:holy_quran_app/extension/media_query_extension.dart';
import 'package:holy_quran_app/provider/app_provider.dart';
import 'package:holy_quran_app/screens/surah_index_screen/viewModel/surah_view_model.dart';
import 'package:holy_quran_app/screens/surah_index_screen/widget/surah_information_widget.dart';
import 'package:holy_quran_app/utils/routes/route_name.dart';

class MyWidget extends StatelessWidget {
  final int? itemCount;
  final SurahViewModel? value;
  final AppProvider? appProvider;
  const MyWidget({super.key, this.itemCount, this.value, this.appProvider});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: context.screenheight * .28),
      child: ListView.separated(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        itemCount: itemCount!,
        separatorBuilder: (context, index) => const Divider(
          color: Color(0xffee8f8b),
        ),
        itemBuilder: (context, index) {
          final surah = value!.surahList.data!.data!.surahs!;
          return InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                RouteName.page,
                arguments: surah[index],
              );
            },
            onLongPress: () => showDialog(
              context: context,
              builder: (context) => SurahInformation(
                surahModel: surah[index],
                appProvider: appProvider!,
                hiveSurah: null,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(surah[index].number.toString()),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        surah[index].englishName.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        surah[index].englishNameTranslation.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Text(
                      surah[index].name.toString(),
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
}
