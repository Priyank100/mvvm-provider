import 'dart:convert';
import 'dart:io';
import 'package:mvvm_provider_example/data/app_exceptions.dart';
import 'package:mvvm_provider_example/data/network/base_api_services.dart';
import 'package:http/http.dart' as http;

class NetworkApiService extends BaseApiServices {

  @override
  Future getGetApiResponse(String url) async {

    dynamic responseJson;
    try{
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);

    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {

    dynamic responseJson;
    try{
      final response = await http.post(Uri.parse(url), body: data).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);

    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch(response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 404:
        throw UnauthorizedException(response.body.toString());
      default:
        throw FetchDataException('Error accured while communicating with server' + ' with status code ' + response.statusCode.toString());
    }
  }

}