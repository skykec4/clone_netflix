import 'package:json_annotation/json_annotation.dart';

part 'videos_model.g.dart';


@JsonSerializable()
class VideosModel {
  int? id;
  List<VideosResults>? results;

  VideosModel({this.id, this.results});

  factory VideosModel.fromJson(Map<String, dynamic> json) => _$VideosModelFromJson(json);
  Map<String, dynamic> toJson() => _$VideosModelToJson(this);
}

@JsonSerializable()
class VideosResults {
  @JsonKey(name: 'iso_639_1')
  String? iso6391;
  @JsonKey(name: 'iso_3166_1')
  String? iso31661;
  String? name;
  String? key;
  String? site;
  int? size;
  String? type;
  bool? official;
  @JsonKey(name: 'published_at')
  String? publishedAt;
  String? id;

  VideosResults(
      {this.iso6391,
        this.iso31661,
        this.name,
        this.key,
        this.site,
        this.size,
        this.type,
        this.official,
        this.publishedAt,
        this.id});

  factory VideosResults.fromJson(Map<String, dynamic> json) => _$VideosResultsFromJson(json);
  Map<String, dynamic> toJson() => _$VideosResultsToJson(this);
}