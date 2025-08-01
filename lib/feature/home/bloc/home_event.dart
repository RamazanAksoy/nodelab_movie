import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeFetched extends HomeEvent {}

class HomeRefreshed extends HomeEvent {}

class HomeFavoriteToggled extends HomeEvent {
  final String movieId;

  const HomeFavoriteToggled(this.movieId);

  @override
  List<Object> get props => [movieId];
}
