import 'package:holy_quran_app/data/network/base_api_services.dart';
import 'package:holy_quran_app/data/network/network_api_services.dart';
import 'package:holy_quran_app/model/juzz/juzz_model.dart';

class JuzzRepository {
  BaseApiServices baseApiServices = NetworkApiServices();

  Future<Juzz> getJuzz(int number) async {
    try {
      final response = await baseApiServices
          .getApi("https://api.alquran.cloud/v1/juz/$number/quran-uthmani");
      return Juzz.fromJson(response);
    } catch (_) {
      rethrow;
    }
  }
}
