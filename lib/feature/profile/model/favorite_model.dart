import '../../../core/base/model/base_model.dart';
import '../../home/model/movie.dart';

class FavoriteMovieResponse extends BaseModel<FavoriteMovieResponse> {
  final List<Movie>? data;

  FavoriteMovieResponse({this.data});

  factory FavoriteMovieResponse.fromJson(Map<String, dynamic> json) {
    return FavoriteMovieResponse(data: (json['data'] as List).map((e) => Movie.fromJson(e)).toList());
  }

  Map<String, dynamic> toJson() {
    return {'data': data?.map((e) => e.toJson()).toList()};
  }

  @override
  FavoriteMovieResponse fromJson(Map<String, dynamic> json) {
    return FavoriteMovieResponse.fromJson(json);
  }
}
