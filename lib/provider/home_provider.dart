import 'package:flutter/material.dart';
import 'package:mvvm_provider_example/data/response/api_response.dart';
import 'package:mvvm_provider_example/model/movie_list_model.dart';
import 'package:mvvm_provider_example/repository/home_repo.dart';

class HomeProvider with ChangeNotifier {

  final _homeRepo = HomeRepo();

  ApiResponse<MovieListModel> movieApiResponse = ApiResponse.loading();

  setMoviesList(ApiResponse<MovieListModel> apiResponse) {
    movieApiResponse = apiResponse;
    notifyListeners();
  }

  Future<void> fetchMovieList() async {
    setMoviesList(ApiResponse.loading());
    _homeRepo.fetchMovieListApi().then((movieListModel) {
      setMoviesList(ApiResponse.completed(movieListModel));
    }).onError((error, stackTrace) {
      setMoviesList(ApiResponse.error(error.toString()));
    });
  }

}