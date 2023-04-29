// To parse this JSON data, do
//
//     final sliderResponse = sliderResponseFromJson(jsonString);

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

SliderResponse sliderResponseFromJson(String str) =>
    SliderResponse.fromJson(json.decode(str));

String sliderResponseToJson(SliderResponse data) => json.encode(data.toJson());

@JsonSerializable()
class SliderResponse {
  SliderResponse({
    required this.error,
    required this.msg,
    required this.data,
  });

  bool error;
  String msg;
  List<Datum> data;

  factory SliderResponse.fromJson(Map<String, dynamic> json) => SliderResponse(
        error: json["error"],
        msg: json["msg"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "msg": msg,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.imageId,
    required this.imageName,
  });

  String imageId;
  String imageName;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        imageId: json["image_id"],
        imageName: json["image_name"],
      );

  Map<String, dynamic> toJson() => {
        "image_id": imageId,
        "image_name": imageName,
      };
}
