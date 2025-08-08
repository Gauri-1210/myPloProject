// To parse this JSON data, do
//
//     final userAddressModel = userAddressModelFromJson(jsonString);

import 'dart:convert';

UserAddressModel userAddressModelFromJson(String str) =>
    UserAddressModel.fromJson(json.decode(str));

String userAddressModelToJson(UserAddressModel data) =>
    json.encode(data.toJson());

class UserAddressModel {
  String? message;
  int? status;
  List<UserAddressData>? data;

  UserAddressModel({this.message, this.status, this.data});

  factory UserAddressModel.fromJson(Map<String, dynamic> json) =>
      UserAddressModel(
        message: json["message"],
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<UserAddressData>.from(
                json["data"]!.map((x) => UserAddressData.fromJson(x)),
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

class UserAddressData {
  String? id;
  String? name;
  String? country;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? zipcode;
  String? phone;
  String? userId;
  bool? deleteStatus;
  bool isSelected;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  UserAddressData({
    this.id,
    this.name,
    this.country,
    this.address1,
    this.address2,
    this.isSelected = false,
    this.city,
    this.state,
    this.zipcode,
    this.phone,
    this.userId,
    this.deleteStatus,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory UserAddressData.fromJson(Map<String, dynamic> json) =>
      UserAddressData(
        id: json["_id"],
        isSelected: false,
        name: json["name"],
        country: json["country"],
        address1: json["address1"],
        address2: json["address2"],
        city: json["city"],
        state: json["state"],
        zipcode: json["zipcode"],
        phone: json["phone"],
        userId: json["userId"],
        deleteStatus: json["deleteStatus"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "country": country,
    "address1": address1,
    "address2": address2,
    "city": city,
    "state": state,
    "zipcode": zipcode,
    "phone": phone,
    "userId": userId,
    "deleteStatus": deleteStatus,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
