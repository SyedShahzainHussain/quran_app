import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:hive_flutter/adapters.dart';
import 'package:holy_quran_app/extension/media_query_extension.dart';
import 'package:holy_quran_app/screens/juz_screen/view_model/juzz_view_model.dart';
import 'package:holy_quran_app/screens/surah_index_screen/viewModel/surah_view_model.dart';
import 'package:provider/provider.dart';

import '../../../provider/app_provider.dart';

class JuzTextField extends StatelessWidget {
  final AppProvider? appProvider;
  const JuzTextField({
    super.key,
    this.appProvider,
  });

  @override
  Widget build(BuildContext context) {
    // final cache = Hive.box('data');
    return Container(
      height: context.screenheight * .05,
      margin: EdgeInsets.only(
        top: context.screenheight * 0.2,
        left: context.screenwidth * .02,
        right: context.screenwidth * .02,
      ),
      child: Consumer<JuzzViewModel>(
        builder: (context, value, _) => TextField(
            cursorColor: appProvider!.isDark ? Colors.white : Colors.black,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: appProvider!.isDark ? Colors.white : Colors.black,
                ),
            onChanged: (value) {
              context.read<JuzzViewModel>().searchJuz(value);
            },
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Search Juz Number here...',
              hintStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: appProvider!.isDark ? Colors.white : Colors.black,
                  ),
              contentPadding: const EdgeInsets.all(10.0),
              focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide(
                    color: appProvider!.isDark ? Colors.white : Colors.black,
                  )),
              border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide(
                    color: appProvider!.isDark ? Colors.white : Colors.black,
                  )),
              enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  borderSide: BorderSide(
                    color: appProvider!.isDark ? Colors.white : Colors.black,
                  )),
              suffixIcon: Icon(
                Icons.search,
                color: appProvider!.isDark ? Colors.white : Colors.grey[800],
              ),
            )),
      ),
    );
  }
}
