import '../../home/model/movie.dart';
import '../../login/model/user.dart';

enum ProfileStatus { initial, loading, success, failure }

class ProfileState {
  final ProfileStatus status;
  final UserResponse? user;
  final List<Movie> favorites;

  ProfileState({this.status = ProfileStatus.initial, this.user, this.favorites = const []});

  ProfileState copyWith({ProfileStatus? status, UserResponse? user, List<Movie>? favorites}) {
    return ProfileState(status: status ?? this.status, user: user ?? this.user, favorites: favorites ?? this.favorites);
  }
}
