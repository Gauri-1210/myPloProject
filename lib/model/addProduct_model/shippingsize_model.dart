// To parse this JSON data, do
//
//     final shippingSizeModel = shippingSizeModelFromJson(jsonString);

import 'dart:convert';

ShippingSizeModel shippingSizeModelFromJson(String str) =>
    ShippingSizeModel.fromJson(json.decode(str));

String shippingSizeModelToJson(ShippingSizeModel data) =>
    json.encode(data.toJson());

class ShippingSizeModel {
  String? message;
  List<ShippingSize>? data;
  int? status;

  ShippingSizeModel({this.message, this.data, this.status});

  factory ShippingSizeModel.fromJson(Map<String, dynamic> json) =>
      ShippingSizeModel(
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<ShippingSize>.from(
                json["data"]!.map((x) => ShippingSize.fromJson(x)),
              ),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
    "status": status,
  };
}

class ShippingSize {
  String? id;
  String? weightUnit;
  int? weightValue;
  String? dimensionUnit;
  int? length;
  int? width;
  int? height;
  bool? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? image;
  String? name;

  ShippingSize({
    this.id,
    this.weightUnit,
    this.weightValue,
    this.dimensionUnit,
    this.length,
    this.width,
    this.height,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.image,
    this.name,
  });

  factory ShippingSize.fromJson(Map<String, dynamic> json) => ShippingSize(
    id: json["_id"],
    weightUnit: json["weightUnit"],
    weightValue: json["weightValue"],
    dimensionUnit: json["dimensionUnit"],
    length: json["length"],
    width: json["width"],
    height: json["height"],
    status: json["status"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    image: json["image"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "weightUnit": weightUnit,
    "weightValue": weightValue,
    "dimensionUnit": dimensionUnit,
    "length": length,
    "width": width,
    "height": height,
    "status": status,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "image": image,
    "name": name,
  };
}
