import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:holy_quran_app/data/response/api_response.dart';
import 'package:holy_quran_app/global/global.dart';
import 'package:holy_quran_app/model/surah/surah_model.dart'
    show SurahModel, Surahs;
import 'package:holy_quran_app/model/surah/surahs.dart' as su;
import 'package:holy_quran_app/model/surah/data.dart' as da;
import 'package:holy_quran_app/screens/surah_index_screen/repository/surah_repository.dart';
import 'package:http/http.dart';

class SurahViewModel with ChangeNotifier {
  // ! repository instance
  final _repo = SurahRepository();

  // ! surah list data from server
  ApiResponse<SurahModel> surahList = ApiResponse.loading();

  // ! surah list data from local database
  ApiResponse<da.Data> dataList = ApiResponse.loading();

  // ! making copy of surah list data from server  and from local database
  List<dynamic> originalSurahs = [];

  // ! update the surah with local data base
  setDataList(ApiResponse<da.Data> dataList) {
    this.dataList = dataList;
    notifyListeners();
  }

  // ! update the surah with api from server
  setSurah(ApiResponse<SurahModel> surahList) {
    this.surahList = surahList;
    if (surahList.data != null) {
      originalSurahs.clear();
      originalSurahs = List.from(surahList
          .data!.data!.surahs!); // * Update the copy of the original data
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

  // ! surah api and storing hive local database
  Future<da.Data> surahsApi() async {
    final resp =
        await get(Uri.parse('http://api.alquran.cloud/v1/quran/quran-uthmani'));

    final Map<String, dynamic> raw = jsonDecode(resp.body)['data'];

    final da.Data chapters = da.Data.fromMap(raw);

    cache.put("surahs", chapters);

    return chapters;
  }

  // ! getting data from local database
  Future<dynamic> chapterHive() async {
    try {
      final chapters = await cache.get('surahs');

      final da.Data? datas = chapters;

      setDataList(ApiResponse.complete(datas));

      originalSurahs.clear();

      originalSurahs.addAll(datas!.surahs!);

      notifyListeners();

      return datas;
    } catch (e) {
      throw Exception("Internal Server Error");
    }
  }

  // ! update Surah By Searching
  void updateSurahList(String searchValue) {
    print("surah internat ${originalSurahs.length}");
    if (searchValue.isEmpty) {
      // * If the search value is empty, reset the surah list to the original data
      surahList.data!.data!.surahs = List.from(originalSurahs);
    } else {
      // * If there is a search value, filter the surahs based on the search criteria
      // * ignore: avoid_single_cascade_in_expression_statements
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

    // * Notify listeners to update the UI
    notifyListeners();
  }

  // ! searching localstorage surah
  void updatesSurahListsFromLocalBase(String searchValue) {
    print("surah local ${originalSurahs.length}");
    if (searchValue.isEmpty) {
      // * If the search value is empty, reset the surah list to the original data
      dataList.data!.surahs = List.from(originalSurahs);
    } else {
      // *  If there is a search value, filter the surahs based on the search criteria
      dataList.data!.surahs = originalSurahs
          .where((surah) =>
              surah.englishName!
                  .toLowerCase()
                  .contains(searchValue.toLowerCase()) ||
              surah.englishNameTranslation!
                  .toLowerCase()
                  .contains(searchValue.toLowerCase()))
          .cast<su.Surahs>()
          .toList();
    }

    // * Notify listeners to update the UI
    notifyListeners();
  }
}
