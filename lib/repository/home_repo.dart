import 'package:mvvm_provider_example/data/network/base_api_services.dart';
import 'package:mvvm_provider_example/data/network/network_api_service.dart';
import 'package:mvvm_provider_example/model/movie_list_model.dart';
import 'package:mvvm_provider_example/resource/app_api.dart';

class HomeRepo {

  BaseApiServices _apiServices = NetworkApiService();

  Future<MovieListModel> fetchMovieListApi() async {
    try{
      var response = await _apiServices.getGetApiResponse(AppApi.moviesUrl);
      return response = MovieListModel.fromJson(response);
    } catch(e) {
      throw e;
    }
  }

}