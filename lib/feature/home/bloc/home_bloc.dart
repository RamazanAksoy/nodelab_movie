import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/movie.dart';
import '../service/home_service.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeService homeService;
  int _page = 1;
  bool _isFetching = false;

  HomeBloc(this.homeService) : super(const HomeState()) {
    on<HomeFetched>(_onFetched);
    on<HomeRefreshed>(_onRefreshed);
    on<HomeFavoriteToggled>(_onFavoriteToggled);
  }

  Future<void> _onFetched(HomeFetched event, Emitter<HomeState> emit) async {
    if (state.hasReachedMax || _isFetching) return;
    _isFetching = true;

    if (_page == 1) emit(state.copyWith(status: HomeStatus.loading));

    final response = await homeService.fetchMovies(_page);
    final data = response?.data?.movies;

    if (data == null) {
      emit(state.copyWith(status: HomeStatus.failure));
      _isFetching = false;
      return;
    }

    emit(state.copyWith(status: HomeStatus.success, movies: [...state.movies, ...data], hasReachedMax: data.isEmpty));
    _page++;
    _isFetching = false;
  }

  Future<void> _onRefreshed(HomeRefreshed event, Emitter<HomeState> emit) async {
    _page = 1;
    emit(state.copyWith(status: HomeStatus.loading, movies: [], hasReachedMax: false));
    add(HomeFetched());
  }

  Future<void> _onFavoriteToggled(HomeFavoriteToggled event, Emitter<HomeState> emit) async {
    final response = await homeService.toggleFavorite(event.movieId);
    final updatedMovie = response?.data?.movie;

    if (updatedMovie != null) {
      final updatedMovies = state.movies.map((movie) {
        return movie.id == updatedMovie.id ? updatedMovie : movie;
      }).toList();

      emit(state.copyWith(movies: updatedMovies));
    }
  }
}
