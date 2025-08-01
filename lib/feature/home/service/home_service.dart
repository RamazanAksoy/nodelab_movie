import '../../../core/base/model/IResponseModel.dart';
import '../../../core/base/service/base_service.dart';
import '../../../core/constants/enums/http_request_enum.dart';
import '../model/movie.dart';

class HomeService with BaseService {
  Future<IResponseModel<MovieResponse?>?> fetchMovies(int page) async {
    final response = await networkManager?.send<MovieResponse, MovieResponse>(
      '/movie/list?page=$page',
      parseModel: MovieResponse(),
      type: HttpTypes.GET,
    );
    return response;
  }

  Future<IResponseModel<MovieResponse?>?> toggleFavorite(String movieId) async {
    final response = await networkManager?.send<MovieResponse, MovieResponse>(
      '/movie/favorite/$movieId',
      parseModel: MovieResponse(),
      type: HttpTypes.POST,
      data: {},
    );
    return response;
  }
}
