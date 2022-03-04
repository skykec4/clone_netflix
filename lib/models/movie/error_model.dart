import 'package:json_annotation/json_annotation.dart';

part 'error_model.g.dart';


@JsonSerializable()
class ErrorModel {
  @JsonKey(name: 'status_code')
  int? statusCode;
  @JsonKey(name: 'status_message')
  String? statusMessage;
  bool? success;

  ErrorModel({this.statusCode, this.statusMessage, this.success});

  factory ErrorModel.fromJson(Map<String, dynamic> json) => _$ErrorModelFromJson(json);
  Map<String, dynamic> toJson() => _$ErrorModelToJson(this);
}