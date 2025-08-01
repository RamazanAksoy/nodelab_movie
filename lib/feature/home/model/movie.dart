import '../../../core/base/model/base_model.dart';

class MovieResponse extends BaseModel<MovieResponse> {
  List<Movie>? movies;
  Movie? movie; // for single movie response (favorite toggle)

  MovieResponse({this.movies, this.movie});

  MovieResponse.fromJson(Map<String, dynamic> json) {
    if (json['data']?['movies'] != null) {
      movies = List<Movie>.from(json['data']['movies'].map((e) => Movie.fromJson(e)));
    }
    if (json['data']?['movie'] != null) {
      movie = Movie.fromJson(json['data']['movie']);
    }
  }

  Map<String, dynamic> toJson() => {};

  @override
  MovieResponse fromJson(Map<String, dynamic> json) {
    return MovieResponse.fromJson(json);
  }
}

class Movie {
  String? id;
  String? title;
  String? year;
  String? rated;
  String? released;
  String? runtime;
  String? genre;
  String? director;
  String? writer;
  String? actors;
  String? plot;
  String? language;
  String? country;
  String? awards;
  String? poster;
  String? metascore;
  String? imdbRating;
  String? imdbVotes;
  String? imdbID;
  String? type;
  String? response;
  List<String>? images;
  bool? comingSoon;
  bool? isFavorite;

  Movie({
    this.id,
    this.title,
    this.year,
    this.rated,
    this.released,
    this.runtime,
    this.genre,
    this.director,
    this.writer,
    this.actors,
    this.plot,
    this.language,
    this.country,
    this.awards,
    this.poster,
    this.metascore,
    this.imdbRating,
    this.imdbVotes,
    this.imdbID,
    this.type,
    this.response,
    this.images,
    this.comingSoon,
    this.isFavorite,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? json['_id'],
      title: json['Title'],
      year: json['Year'],
      rated: json['Rated'],
      released: json['Released'],
      runtime: json['Runtime'],
      genre: json['Genre'],
      director: json['Director'],
      writer: json['Writer'],
      actors: json['Actors'],
      plot: json['Plot'],
      language: json['Language'],
      country: json['Country'],
      awards: json['Awards'],
      poster: json['Poster'],
      metascore: json['Metascore'],
      imdbRating: json['imdbRating'],
      imdbVotes: json['imdbVotes'],
      imdbID: json['imdbID'],
      type: json['Type'],
      response: json['Response'],
      images: (json['Images'] as List?)?.map((e) => e.toString()).toList(),
      comingSoon: json['ComingSoon'],
      isFavorite: json['isFavorite'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "Title": title,
      "Year": year,
      "Rated": rated,
      "Released": released,
      "Runtime": runtime,
      "Genre": genre,
      "Director": director,
      "Writer": writer,
      "Actors": actors,
      "Plot": plot,
      "Language": language,
      "Country": country,
      "Awards": awards,
      "Poster": poster,
      "Metascore": metascore,
      "imdbRating": imdbRating,
      "imdbVotes": imdbVotes,
      "imdbID": imdbID,
      "Type": type,
      "Response": response,
      "Images": images,
      "ComingSoon": comingSoon,
      "isFavorite": isFavorite,
    };
  }
}
