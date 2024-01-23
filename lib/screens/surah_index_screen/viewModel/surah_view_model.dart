import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:holy_quran_app/data/response/api_response.dart';
import 'package:holy_quran_app/global/global.dart';
import 'package:holy_quran_app/model/surah_model.dart' show SurahModel, Surahs;
import 'package:holy_quran_app/model/surahs.dart' as su;
import 'package:holy_quran_app/screens/surah_index_screen/repository/surah_repository.dart';
import 'package:http/http.dart';

class SurahViewModel with ChangeNotifier {
  final _repo = SurahRepository();
  List<dynamic> get surahHiveList => _surahHiveList;
  final List<dynamic> _surahHiveList = [];
  ApiResponse<SurahModel> surahList = ApiResponse.loading();
  List<dynamic> originalSurahs = [];

  setSurah(ApiResponse<SurahModel> surahList) {
    this.surahList = surahList;
    if (surahList.data != null) {
      originalSurahs = List.from(surahList
          .data!.data!.surahs!); // Update the copy of the original data
    }
    notifyListeners();
  }

  // ! get Surah
  void getSurah() {
    setSurah(ApiResponse.loading());
    _repo.getSurah().then((value) async {
      setSurah(
        ApiResponse.complete(value),
      );
    }).onError((error, stackTrace) {
      setSurah(
        ApiResponse.error(error.toString()),
      );
    });
  }

// ! update Surah By Searching
  void updateSurahList(String searchValue) {
    if (searchValue.isEmpty) {
      // If the search value is empty, reset the surah list to the original data
      surahList.data!.data!.surahs = List.from(originalSurahs);
    } else {
      // If there is a search value, filter the surahs based on the search criteria
      // ignore: avoid_single_cascade_in_expression_statements
      surahList.data!.data!.surahs = originalSurahs
          .where((surah) =>
              surah.englishName!
                  .toLowerCase()
                  .contains(searchValue.toLowerCase()) ||
              surah.englishNameTranslation!
                  .toLowerCase()
                  .contains(searchValue.toLowerCase()))
          .cast<Surahs>()
          .toList();
    }

    // Notify listeners to update the UI
    notifyListeners();
  }

  // ! surah api and storing hive local database
  Future<List<su.Surahs>> surahsApi() async {
    final resp =
        await get(Uri.parse('http://api.alquran.cloud/v1/quran/quran-uthmani'));
    final Map<String, dynamic> raw = jsonDecode(resp.body)['data'];
    final List data = raw['surahs'];

    final List<su.Surahs> chapters = List.generate(data.length, (index) {
      return su.Surahs.fromMap(data[index]);
    });
    cache.put("surahs", chapters);

    return chapters;
  }

  // ! searching localstorage surah
  void updatesSurahList(String searchValue) {
    print("..");
    if (searchValue.isEmpty) {
      // If the search value is empty, reset the surah list to the original data
      _surahHiveList.clear();
      _surahHiveList.addAll(originalSurahs);
    } else {
      // If there is a search value, filter the surahs based on the search criteria
      _surahHiveList.clear();
      _surahHiveList.addAll(
        originalSurahs
            .where((surah) =>
                surah.englishName!
                    .toLowerCase()
                    .contains(searchValue.toLowerCase()) ||
                surah.englishNameTranslation!
                    .toLowerCase()
                    .contains(searchValue.toLowerCase()))
            .toList(),
      );
    }

    // Notify listeners to update the UI
    notifyListeners();
  }

  Future<dynamic> chapterHive() async {
    try {
      final chapters = await cache.get('surahs');

      final List<su.Surahs?> datas = List.from(chapters);
      originalSurahs.clear();
      surahHiveList.clear();
      originalSurahs.addAll(datas);
      surahHiveList.addAll(datas);
      notifyListeners();
      return datas;
    } catch (e) {
      throw Exception("Internal Server Error");
    }
  }
}
