import 'package:flutter/foundation.dart';
import 'package:holy_quran_app/data/response/api_response.dart';
import 'package:holy_quran_app/model/surah_model.dart';
import 'package:holy_quran_app/screens/surah_index_screen/repository/surah_repository.dart';

class SurahViewModel with ChangeNotifier {
  final _repo = SurahRepository();
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

  void getSurah() {
    setSurah(ApiResponse.loading());
    _repo.getSurah().then((value) {
      setSurah(
        ApiResponse.complete(value),
      );
    }).onError((error, stackTrace) {
      setSurah(
        ApiResponse.error(error.toString()),
      );
    });
  }

  void updateSurahList(String searchValue) {
    if (searchValue.isEmpty) {
      // If the search value is empty, reset the surah list to the original data
      surahList.data!.data!.surahs = List.from(originalSurahs);
    } else {
      // If there is a search value, filter the surahs based on the search criteria
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
}
