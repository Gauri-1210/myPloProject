// To parse this JSON data, do
//
//     final activeCategoriesModel = activeCategoriesModelFromJson(jsonString);

import 'dart:convert';

ActiveCategoriesModel activeCategoriesModelFromJson(String str) =>
    ActiveCategoriesModel.fromJson(json.decode(str));

String activeCategoriesModelToJson(ActiveCategoriesModel data) =>
    json.encode(data.toJson());

class ActiveCategoriesModel {
  String? message;
  int? status;
  List<Categories>? data;

  ActiveCategoriesModel({this.message, this.status, this.data});

  factory ActiveCategoriesModel.fromJson(Map<String, dynamic> json) =>
      ActiveCategoriesModel(
        message: json["message"],
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<Categories>.from(
                json["data"]!.map((x) => Categories.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Categories {
  String? id;
  String? categoryName;
  String? description;
  bool? featured;
  bool? status;
  String? image;
  bool? conditionFilter;
  bool? weightFilter;
  bool? buyNow;
  String? type;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? seoTitle;

  Categories({
    this.id,
    this.categoryName,
    this.description,
    this.featured,
    this.status,
    this.image,
    this.conditionFilter,
    this.weightFilter,
    this.buyNow,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.seoTitle,
  });

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
    id: json["_id"],
    categoryName: json["categoryName"],
    description: json["description"],
    featured: json["featured"],
    status: json["status"],
    image: json["image"],
    conditionFilter: json["conditionFilter"],
    weightFilter: json["weightFilter"],
    buyNow: json["buyNow"],
    type: json["type"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    seoTitle: json["seoTitle"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "categoryName": categoryName,
    "description": description,
    "featured": featured,
    "status": status,
    "image": image,
    "conditionFilter": conditionFilter,
    "weightFilter": weightFilter,
    "buyNow": buyNow,
    "type": type,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "seoTitle": seoTitle,
  };
}
