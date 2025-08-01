import '../../../core/base/model/IResponseModel.dart';
import '../../../core/base/service/base_service.dart';
import '../../../core/constants/enums/http_request_enum.dart';
import '../../login/model/user.dart';
import '../model/favorite_model.dart';

class ProfileService with BaseService {
  Future<IResponseModel<UserResponse?>?> fetchProfile() async {
    final response = await networkManager?.send<UserResponse, UserResponse>('/user/profile', parseModel: UserResponse(), type: HttpTypes.GET);
    return response;
  }

  Future<IResponseModel<FavoriteMovieResponse?>?> fetchFavoriteMovies() async {
    final response = await networkManager?.send<FavoriteMovieResponse, FavoriteMovieResponse>(
      '/movie/favorites',
      parseModel: FavoriteMovieResponse(),
      type: HttpTypes.GET,
    );
    return response;
  }

  Future<IResponseModel<UserResponse?>?> uploadPhoto(String filePath) async {
    final response = await networkManager?.send<UserResponse, UserResponse>('/user/upload_photo', parseModel: UserResponse(), type: HttpTypes.POST);
    return response;
  }
}
