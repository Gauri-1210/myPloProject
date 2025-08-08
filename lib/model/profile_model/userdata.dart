// To parse this JSON data, do
//
//     final userDataModel = userDataModelFromJson(jsonString);

import 'dart:convert';

UserDataModel userDataModelFromJson(String str) =>
    UserDataModel.fromJson(json.decode(str));

String userDataModelToJson(UserDataModel data) => json.encode(data.toJson());

class UserDataModel {
  String? message;
  int? status;
  UserProfileData? data;

  UserDataModel({this.message, this.status, this.data});

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
    message: json["message"],
    status: json["status"],
    data: json["data"] == null ? null : UserProfileData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": data?.toJson(),
  };
}

class UserProfileData {
  String? id;
  String? fullName;
  String? email;
  String? password;
  bool? status;
  String? stripeAccountId;
  String? role;
  int? averageRating;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? avatar;
  bool? isConnected;
  int? notificationCount;
  int? totalServices;
  int? totalBookings;
  StripeSummary? stripeSummary;

  UserProfileData({
    this.id,
    this.fullName,
    this.email,
    this.password,
    this.status,
    this.stripeAccountId,
    this.role,
    this.averageRating,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.avatar,
    this.isConnected,
    this.notificationCount,
    this.totalServices,
    this.totalBookings,
    this.stripeSummary,
  });

  factory UserProfileData.fromJson(Map<String, dynamic> json) =>
      UserProfileData(
        id: json["_id"],
        fullName: json["fullName"],
        email: json["email"],
        password: json["password"],
        status: json["status"],
        stripeAccountId: json["stripeAccountId"],
        role: json["role"],
        averageRating: json["averageRating"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        avatar: json["avatar"],
        isConnected: json["is_connected"],
        notificationCount: json["notificationCount"],
        totalServices: json["totalServices"],
        totalBookings: json["totalBookings"],
        stripeSummary: json["stripeSummary"] == null
            ? null
            : StripeSummary.fromJson(json["stripeSummary"]),
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
    "email": email,
    "password": password,
    "status": status,
    "stripeAccountId": stripeAccountId,
    "role": role,
    "averageRating": averageRating,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "avatar": avatar,
    "is_connected": isConnected,
    "notificationCount": notificationCount,
    "totalServices": totalServices,
    "totalBookings": totalBookings,
    "stripeSummary": stripeSummary?.toJson(),
  };
}

class StripeSummary {
  int? totalEarned;
  int? payoutsSent;
  int? pendingEarnings;

  StripeSummary({this.totalEarned, this.payoutsSent, this.pendingEarnings});

  factory StripeSummary.fromJson(Map<String, dynamic> json) => StripeSummary(
    totalEarned: json["totalEarned"],
    payoutsSent: json["payoutsSent"],
    pendingEarnings: json["pendingEarnings"],
  );

  Map<String, dynamic> toJson() => {
    "totalEarned": totalEarned,
    "payoutsSent": payoutsSent,
    "pendingEarnings": pendingEarnings,
  };
}
