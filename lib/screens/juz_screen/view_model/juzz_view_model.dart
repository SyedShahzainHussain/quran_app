import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:holy_quran_app/data/response/api_response.dart';
import 'package:holy_quran_app/model/juzz/juzz_model.dart';
import 'package:holy_quran_app/screens/juz_screen/repository/juzz_repository.dart';
import 'package:holy_quran_app/model/juzz/juzz.dart' as ju;
import 'package:http/http.dart';

import '../../../global/global.dart';

class JuzzViewModel with ChangeNotifier {
  JuzzRepository juzzRepository = JuzzRepository();
  ApiResponse<Juzz> apiResponse = ApiResponse.loading();
  ApiResponse<ju.Juzz> localResponse = ApiResponse.loading();
  setJuzz(ApiResponse<Juzz> apiResponse) {
    this.apiResponse = apiResponse;
    notifyListeners();
  }

  ApiResponse<ju.Juzz> localjuzz = ApiResponse.loading();

  setLocalJuzz(ApiResponse<ju.Juzz> localResponse) {
    this.localResponse = localResponse;
    notifyListeners();
  }

  clearSearchValue() {
    searchedJuzName = "";
    notifyListeners();
  }

  final List<String> _juzNames = [
    'آلم',
    'سَيَقُولُ',
    'تِلْكَ ٱلْرُّسُلُ',
    'لَنْ  تَنَالُو',
    'وَٱلْمُحْصَنَاتُ',
    'لَا يُحِبُّ ٱللهُ',
    'وَإِذَا سَمِعُوا',
    'وَلَوْ أَنَّنَا',
    'قَالَ ٱلْمَلَأُ',
    'وَٱعْلَمُواْ',
    'يَعْتَذِرُونَ',
    'وَمَا مِنْ دَآبَّةٍ',
    'وَمَا أُبَرِّئُ',
    'رُبَمَا',
    'سُبْحَانَ ٱلَّذِى',
    'قَالَ أَلَمْ',
    'ٱقْتَرَبَ لِلْنَّاس',
    'قَدْ أَفْلَحَ',
    'وَقَالَ ٱلَّذِينَ',
    'أَمَّنْ خَلَقَ',
    'أُتْلُ مَاأُوْحِیَ',
    'وَمَنْ يَّقْنُتْ',
    'وَمَآ لي',
    'فَمَنْ أَظْلَمُ',
    'إِلَيْهِ يُرَدُّ',
    'حم',
    'قَالَ فَمَا خَطْبُكُم',
    'قَدْ سَمِعَ ٱللهُ',
    'تَبَارَكَ ٱلَّذِى',
    'عَمَّ',
  ];

  List<String> get juzNames => _juzNames;

  String searchedJuzName = '';

  // ! searchJuz
  void searchJuz(String value) {
    if (value.isEmpty || !_isNumeric(value)) {
      searchedJuzName = "";
    } else {
      int? search = int.parse(value);
      if (search <= _juzNames.length && search > 0) {
        searchedJuzName = _juzNames[search - 1];
      }
    }
    notifyListeners();
  }

  // ! check is numerical
  bool _isNumeric(String value) {
    final numericRegex = RegExp(r'^[0-9]+$');
    return numericRegex.hasMatch(value);
  }

  // ! getJuzz
  void getJuzz(int numbers) {
    juzzRepository.getJuzz(numbers).then((value) async {
      if (kDebugMode) {
        print(value);
      }

      setJuzz(ApiResponse.complete(value));
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error);
        print(stackTrace);
      }
      setJuzz(ApiResponse.error(error.toString()));
    });
  }

  // ! juzz api and storing hive local database
  Future<ju.Juzz> juzzApi(int numbers) async {
    final resp = await get(
        Uri.parse('https://api.alquran.cloud/v1/juz/$numbers/quran-uthmani'));
    final Map<String, dynamic> raw = jsonDecode(resp.body)['data'];
    final ju.Juzz juz = ju.Juzz.fromMap(raw);

    await cache.put("juz$numbers", juz);

    return juz;
  }

  // ! juzz api get from local database
  void juzzHive(int numbers) async {
    try {
      final juzz = await cache.get('juz$numbers');

      setLocalJuzz(ApiResponse.complete(juzz));
    } catch (e) {
      throw Exception("Internal Server Error");
    }
  }
}
