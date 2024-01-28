import 'package:mvvm_provider_example/data/network/base_api_services.dart';
import 'package:mvvm_provider_example/data/network/network_api_service.dart';
import 'package:mvvm_provider_example/resource/app_api.dart';

class AuthRepo {

  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> loginApi(var data) async {
    try{
      var response = await _apiServices.getPostApiResponse(AppApi.loginUrl, data);
      return response;
    } catch(e) {
      throw e;
    }
  }

  Future<dynamic> registerApi(var data) async {
    try{
      var response = await _apiServices.getPostApiResponse(AppApi.registerUrl, data);
      return response;
    } catch(e) {
      throw e;
    }
  }

}