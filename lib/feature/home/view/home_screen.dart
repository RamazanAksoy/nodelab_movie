// HomeScreen with full-screen movie cards and vertical scroll

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/constants/image/images.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../model/movie.dart';
import '../service/home_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => HomeBloc(HomeService())..add(HomeFetched()), child: const HomeView());
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_pageController.position.pixels >= _pageController.position.maxScrollExtent - 300) {
      context.read<HomeBloc>().add(HomeFetched());
    }
  }

  Future<void> _onRefresh() async {
    context.read<HomeBloc>().add(HomeRefreshed());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state.status == HomeStatus.initial || state.status == HomeStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.vertical,
                itemCount: state.hasReachedMax ? state.movies.length : state.movies.length + 1,
                itemBuilder: (context, index) {
                  if (index >= state.movies.length) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final movie = state.movies[index];
                  return MovieCard(
                    movie: movie,
                    onFavoriteToggle: () {
                      context.read<HomeBloc>().add(HomeFavoriteToggled(movie.id ?? ""));
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class MovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback onFavoriteToggle;

  const MovieCard({super.key, required this.movie, required this.onFavoriteToggle});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      child: Stack(fit: StackFit.expand, children: [_buildBackgroundImage(), _buildGradientOverlay(), _buildBottomContent(context)]),
    );
  }

  Widget _buildBackgroundImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.network(
        movie.images?.first ?? "",
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey),
      ),
    );
  }

  Widget _buildGradientOverlay() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [Colors.black.withOpacity(0.8), Colors.transparent],
        ),
      ),
    );
  }

  Widget _buildBottomContent(BuildContext context) {
    return Positioned(
      left: 16,
      right: 16,
      bottom: 30,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [_buildMovieLogo(), const SizedBox(width: 12), _buildTitleAndDescription(), const SizedBox(width: 12), _buildFavoriteButton()],
      ),
    );
  }

  Widget _buildMovieLogo() {
    return ClipOval(
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Padding(padding: const EdgeInsets.all(8.0), child: Image.asset(AppImages.instance.movieLogo, width: 20, height: 20)),
      ),
    );
  }

  Widget _buildTitleAndDescription() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            movie.title ?? "",
            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            movie.plot ?? "",
            style: const TextStyle(color: Colors.white70, overflow: TextOverflow.ellipsis),
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteButton() {
    return Container(
      height: 9.h,
      width: 13.w,
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1),
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(100),
      ),
      child: IconButton(
        icon: Icon((movie.isFavorite ?? false) ? Icons.favorite : Icons.favorite_border, color: Colors.white70),
        onPressed: onFavoriteToggle,
      ),
    );
  }
}
