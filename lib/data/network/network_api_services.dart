import 'dart:io';

import 'package:holy_quran_app/data/app_exception.dart';
import 'package:holy_quran_app/data/network/base_api_services.dart';
import 'package:http/http.dart';
import 'dart:convert';

class NetworkApiServices extends BaseApiServices {
  @override
  Future getApi(String url) async {
    dynamic jsonRespone;
    try {
      dynamic response = await get(Uri.parse(url));
      jsonRespone = returnResponse(response);
    } on SocketException {
      throw FetchDataException(message: "No Internet Connection");
    }
    return jsonRespone;
  }
}

dynamic returnResponse(Response response) {
  switch (response.statusCode) {
    case 200:
      dynamic returnResponse = jsonDecode(response.body);
      return returnResponse;
    case 400:
      throw BadRequestException(message: response.body.toString());
    case 500:
      throw BadRequestException(message: response.body.toString());
    case 404:
      throw UnauthorizedException(message: response.body.toString());
    default:
      throw FetchDataException(
          message:
              'Error occured while communicate with serverwith status code${response.statusCode}');
  }
}
