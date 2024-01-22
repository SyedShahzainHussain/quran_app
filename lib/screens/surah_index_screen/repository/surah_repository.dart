import 'package:holy_quran_app/data/network/base_api_services.dart';
import 'package:holy_quran_app/data/network/network_api_services.dart';
import 'package:holy_quran_app/model/surah_model.dart';
import 'package:holy_quran_app/utils/app_url.dart';

class SurahRepository {
  BaseApiServices baseApiService = NetworkApiServices();

  Future<SurahModel> getSurah() async {
    try {
      dynamic response = await baseApiService.getApi(surahIndex);
      return SurahModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
