// To parse this JSON data, do
//
//     final categoryProductDataModel = categoryProductDataModelFromJson(jsonString);

import 'dart:convert';

CategoryProductDataModel categoryProductDataModelFromJson(String str) =>
    CategoryProductDataModel.fromJson(json.decode(str));

String categoryProductDataModelToJson(CategoryProductDataModel data) =>
    json.encode(data.toJson());

class CategoryProductDataModel {
  String? message;
  int? status;
  List<CategoryProductData>? data;

  CategoryProductDataModel({this.message, this.status, this.data});

  factory CategoryProductDataModel.fromJson(Map<String, dynamic> json) =>
      CategoryProductDataModel(
        message: json["message"],
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<CategoryProductData>.from(
                json["data"]!.map((x) => CategoryProductData.fromJson(x)),
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

class CategoryProductData {
  Weight? weight;
  String? id;
  String? title;
  String? description;
  List<String>? gallery;
  String? location;
  String? categoryId;
  String? subCategoryId;
  String? userId;
  String? condition;
  String? sellingStatus;
  bool? status;
  bool? isDeleted;
  int? price;
  String? type;
  String? video;
  int? restTime;
  List<dynamic>? availabilityDays;
  String? shippingSizeId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  CategoryProductData({
    this.weight,
    this.id,
    this.title,
    this.description,
    this.gallery,
    this.location,
    this.categoryId,
    this.subCategoryId,
    this.userId,
    this.condition,
    this.sellingStatus,
    this.status,
    this.isDeleted,
    this.price,
    this.type,
    this.video,
    this.restTime,
    this.availabilityDays,
    this.shippingSizeId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory CategoryProductData.fromJson(Map<String, dynamic> json) =>
      CategoryProductData(
        weight: json["weight"] == null ? null : Weight.fromJson(json["weight"]),
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        gallery: json["gallery"] == null
            ? []
            : List<String>.from(json["gallery"]!.map((x) => x)),
        location: json["location"],
        categoryId: json["categoryId"],
        subCategoryId: json["subCategoryId"],
        userId: json["userId"],
        condition: json["condition"],
        sellingStatus: json["sellingStatus"],
        status: json["status"],
        isDeleted: json["isDeleted"],
        price: json["price"],
        type: json["type"],
        video: json["video"],
        restTime: json["restTime"],
        availabilityDays: json["availabilityDays"] == null
            ? []
            : List<dynamic>.from(json["availabilityDays"]!.map((x) => x)),
        shippingSizeId: json["shippingSizeId"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
    "weight": weight?.toJson(),
    "_id": id,
    "title": title,
    "description": description,
    "gallery": gallery == null
        ? []
        : List<dynamic>.from(gallery!.map((x) => x)),
    "location": location,
    "categoryId": categoryId,
    "subCategoryId": subCategoryId,
    "userId": userId,
    "condition": condition,
    "sellingStatus": sellingStatus,
    "status": status,
    "isDeleted": isDeleted,
    "price": price,
    "type": type,
    "video": video,
    "restTime": restTime,
    "availabilityDays": availabilityDays == null
        ? []
        : List<dynamic>.from(availabilityDays!.map((x) => x)),
    "shippingSizeId": shippingSizeId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Weight {
  int? min;
  int? max;

  Weight({this.min, this.max});

  factory Weight.fromJson(Map<String, dynamic> json) =>
      Weight(min: json["min"], max: json["max"]);

  Map<String, dynamic> toJson() => {"min": min, "max": max};
}
