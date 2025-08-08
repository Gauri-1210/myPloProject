// To parse this JSON data, do
//
//     final userHomeDataModel = userHomeDataModelFromJson(jsonString);

import 'dart:convert';

UserHomeDataModel userHomeDataModelFromJson(String str) =>
    UserHomeDataModel.fromJson(json.decode(str));

String userHomeDataModelToJson(UserHomeDataModel data) =>
    json.encode(data.toJson());

class UserHomeDataModel {
  String? message;
  int? status;
  List<ProductData>? data;
  List<Category>? categories;
  bool? isConnected;
  bool? isMailConnected;

  UserHomeDataModel({
    this.message,
    this.status,
    this.data,
    this.categories,
    this.isConnected,
    this.isMailConnected,
  });

  factory UserHomeDataModel.fromJson(Map<String, dynamic> json) =>
      UserHomeDataModel(
        message: json["message"],
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<ProductData>.from(
                json["data"]!.map((x) => ProductData.fromJson(x)),
              ),
        categories: json["categories"] == null
            ? []
            : List<Category>.from(
                json["categories"]!.map((x) => Category.fromJson(x)),
              ),
        isConnected: json["is_connected"],
        isMailConnected: json["is_mail_connected"],
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
    "categories": categories == null
        ? []
        : List<dynamic>.from(categories!.map((x) => x.toJson())),
    "is_connected": isConnected,
    "is_mail_connected": isMailConnected,
  };
}

class Category {
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

  Category({
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

  factory Category.fromJson(Map<String, dynamic> json) => Category(
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

class ProductData {
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

  ProductData({
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

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
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
