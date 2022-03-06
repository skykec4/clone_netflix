import 'package:json_annotation/json_annotation.dart';

part 'now_palying_model.g.dart';

@JsonSerializable()
class NowPlayingModel {
  @JsonKey(name: 'status_message')
  String? statusMessage;
  @JsonKey(name: 'status_code')
  int? statusCode;
  bool? success;
  Dates? dates;
  int? page;
  List<Results>? results;
  @JsonKey(name: 'total_pages')
  int? totalPages;
  @JsonKey(name: 'total_results')
  int? totalResults;

  NowPlayingModel(
      {this.statusMessage,
      this.success,
      this.statusCode,
      this.dates,
      this.page,
      this.results,
      this.totalPages,
      this.totalResults});

  factory NowPlayingModel.fromJson(Map<String, dynamic> json) =>
      _$NowPlayingModelFromJson(json);

  Map<String, dynamic> toJson() => _$NowPlayingModelToJson(this);
}

@JsonSerializable()
class Dates {
  String? maximum;
  String? minimum;

  Dates({this.maximum, this.minimum});

  factory Dates.fromJson(Map<String, dynamic> json) => _$DatesFromJson(json);

  Map<String, dynamic> toJson() => _$DatesToJson(this);
}

@JsonSerializable()
class Results {
  bool? adult;
  @JsonKey(name: 'backdrop_path')
  String? backdropPath;
  @JsonKey(name: 'genre_ids')
  List<int>? genreIds;
  int? id;
  @JsonKey(name: 'original_language')
  String? originalLanguage;
  @JsonKey(name: 'original_title')
  String? originalTitle;
  String? overview;
  double? popularity;
  @JsonKey(name: 'poster_path')
  String? posterPath;
  @JsonKey(name: 'release_date')
  String? releaseDate;
  String? title;
  bool? video;
  @JsonKey(name: 'vote_average')
  double? voteAverage;
  @JsonKey(name: 'vote_count')
  int? voteCount;
  @JsonKey(name: 'media_type')
  String? mediaType;
  String? name;
  @JsonKey(name: 'first_air_date')
  String? firstAirDate;

  Results(
      {this.adult,
      this.backdropPath,
      this.genreIds,
      this.id,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.releaseDate,
      this.title,
      this.video,
      this.voteAverage,
      this.voteCount,
      this.mediaType,
      this.name,
      this.firstAirDate});

  factory Results.fromJson(Map<String, dynamic> json) =>
      _$ResultsFromJson(json);

  Map<String, dynamic> toJson() => _$ResultsToJson(this);
}
