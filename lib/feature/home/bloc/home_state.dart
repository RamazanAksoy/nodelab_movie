import 'package:equatable/equatable.dart';
import '../model/movie.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<Movie> movies;
  final bool hasReachedMax;

  const HomeState({this.status = HomeStatus.initial, this.movies = const [], this.hasReachedMax = false});

  HomeState copyWith({HomeStatus? status, List<Movie>? movies, bool? hasReachedMax}) {
    return HomeState(status: status ?? this.status, movies: movies ?? this.movies, hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }

  @override
  List<Object> get props => [status, movies, hasReachedMax];
}
