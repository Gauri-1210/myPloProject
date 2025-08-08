// To parse this JSON data, do
//
//     final userDashboardData = userDashboardDataFromJson(jsonString);

import 'dart:convert';

UserDashboardData userDashboardDataFromJson(String str) =>
    UserDashboardData.fromJson(json.decode(str));

String userDashboardDataToJson(UserDashboardData data) =>
    json.encode(data.toJson());

class UserDashboardData {
  String? message;
  int? status;
  Data? data;

  UserDashboardData({this.message, this.status, this.data});

  factory UserDashboardData.fromJson(Map<String, dynamic> json) =>
      UserDashboardData(
        message: json["message"],
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": data?.toJson(),
  };
}

class Data {
  List<SellingProduct>? sellingProducts;
  List<Favourite>? favourites;
  List<dynamic>? soldProducts;
  List<PurchasedOrder>? purchasedOrders;
  List<Offer>? offer;
  UserData? userData;
  List<dynamic>? bookings;

  Data({
    this.sellingProducts,
    this.favourites,
    this.soldProducts,
    this.purchasedOrders,
    this.offer,
    this.userData,
    this.bookings,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    sellingProducts: json["sellingProducts"] == null
        ? []
        : List<SellingProduct>.from(
            json["sellingProducts"]!.map((x) => SellingProduct.fromJson(x)),
          ),
    favourites: json["favourites"] == null
        ? []
        : List<Favourite>.from(
            json["favourites"]!.map((x) => Favourite.fromJson(x)),
          ),
    soldProducts: json["soldProducts"] == null
        ? []
        : List<dynamic>.from(json["soldProducts"]!.map((x) => x)),
    purchasedOrders: json["purchasedOrders"] == null
        ? []
        : List<PurchasedOrder>.from(
            json["purchasedOrders"]!.map((x) => PurchasedOrder.fromJson(x)),
          ),
    offer: json["offer"] == null
        ? []
        : List<Offer>.from(json["offer"]!.map((x) => Offer.fromJson(x))),
    userData: json["userData"] == null
        ? null
        : UserData.fromJson(json["userData"]),
    bookings: json["bookings"] == null
        ? []
        : List<dynamic>.from(json["bookings"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "sellingProducts": sellingProducts == null
        ? []
        : List<dynamic>.from(sellingProducts!.map((x) => x.toJson())),
    "favourites": favourites == null
        ? []
        : List<dynamic>.from(favourites!.map((x) => x.toJson())),
    "soldProducts": soldProducts == null
        ? []
        : List<dynamic>.from(soldProducts!.map((x) => x)),
    "purchasedOrders": purchasedOrders == null
        ? []
        : List<dynamic>.from(purchasedOrders!.map((x) => x.toJson())),
    "offer": offer == null
        ? []
        : List<dynamic>.from(offer!.map((x) => x.toJson())),
    "userData": userData?.toJson(),
    "bookings": bookings == null
        ? []
        : List<dynamic>.from(bookings!.map((x) => x)),
  };
}

class Favourite {
  String? id;
  String? userId;
  SellingProduct? productId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Favourite({
    this.id,
    this.userId,
    this.productId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Favourite.fromJson(Map<String, dynamic> json) => Favourite(
    id: json["_id"],
    userId: json["userId"],
    productId: json["productId"] == null
        ? null
        : SellingProduct.fromJson(json["productId"]),
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
    "userId": userId,
    "productId": productId?.toJson(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class SellingProduct {
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
  double? latitude;
  double? longitude;

  SellingProduct({
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
    this.latitude,
    this.longitude,
  });

  factory SellingProduct.fromJson(Map<String, dynamic> json) => SellingProduct(
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
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
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
    "latitude": latitude,
    "longitude": longitude,
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

class Offer {
  String? id;
  SellingProduct? productId;
  UserData? buyerId;
  SellerId? sellerId;
  int? requestedAmount;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Offer({
    this.id,
    this.productId,
    this.buyerId,
    this.sellerId,
    this.requestedAmount,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
    id: json["_id"],
    productId: json["productId"] == null
        ? null
        : SellingProduct.fromJson(json["productId"]),
    buyerId: json["buyerId"] == null
        ? null
        : UserData.fromJson(json["buyerId"]),
    sellerId: json["sellerId"] == null
        ? null
        : SellerId.fromJson(json["sellerId"]),
    requestedAmount: json["requestedAmount"],
    status: json["status"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  get gallery => null;

  Map<String, dynamic> toJson() => {
    "_id": id,
    "productId": productId?.toJson(),
    "buyerId": buyerId?.toJson(),
    "sellerId": sellerId?.toJson(),
    "requestedAmount": requestedAmount,
    "status": status,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class UserData {
  String? id;
  String? fullName;
  String? email;
  bool? status;
  String? stripeAccountId;
  String? role;
  int? averageRating;
  String? type;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? password;
  bool? isConnected;

  UserData({
    this.id,
    this.fullName,
    this.email,
    this.status,
    this.stripeAccountId,
    this.role,
    this.averageRating,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.password,
    this.isConnected,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json["_id"],
    fullName: json["fullName"],
    email: json["email"],
    status: json["status"],
    stripeAccountId: json["stripeAccountId"],
    role: json["role"],
    averageRating: json["averageRating"],
    type: json["type"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    password: json["password"],
    isConnected: json["is_connected"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
    "email": email,
    "status": status,
    "stripeAccountId": stripeAccountId,
    "role": role,
    "averageRating": averageRating,
    "type": type,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "password": password,
    "is_connected": isConnected,
  };
}

class SellerId {
  String? id;
  String? fullName;
  String? email;
  String? password;
  bool? status;
  String? stripeAccountId;
  String? role;
  double? averageRating;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? avatar;
  String? city;
  int? phone;
  String? state;
  String? userName;

  SellerId({
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
    this.city,
    this.phone,
    this.state,
    this.userName,
  });

  factory SellerId.fromJson(Map<String, dynamic> json) => SellerId(
    id: json["_id"],
    fullName: json["fullName"],
    email: json["email"],
    password: json["password"],
    status: json["status"],
    stripeAccountId: json["stripeAccountId"],
    role: json["role"],
    averageRating: json["averageRating"]?.toDouble(),
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    avatar: json["avatar"],
    city: json["city"],
    phone: json["phone"],
    state: json["state"],
    userName: json["userName"],
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
    "city": city,
    "phone": phone,
    "state": state,
    "userName": userName,
  };
}

class PurchasedOrder {
  String? id;
  String? userId;
  String? sellerId;
  String? addressId;
  SellingProduct? productId;
  double? total;
  double? shipping;
  bool? isRating;
  String? shippingSizeId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  PurchasedOrder({
    this.id,
    this.userId,
    this.sellerId,
    this.addressId,
    this.productId,
    this.total,
    this.shipping,
    this.isRating,
    this.shippingSizeId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory PurchasedOrder.fromJson(Map<String, dynamic> json) => PurchasedOrder(
    id: json["_id"],
    userId: json["userId"],
    sellerId: json["sellerId"],
    addressId: json["addressId"],
    productId: json["productId"] == null
        ? null
        : SellingProduct.fromJson(json["productId"]),
    total: json["total"]?.toDouble(),
    shipping: json["shipping"]?.toDouble(),
    isRating: json["isRating"],
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
    "_id": id,
    "userId": userId,
    "sellerId": sellerId,
    "addressId": addressId,
    "productId": productId?.toJson(),
    "total": total,
    "shipping": shipping,
    "isRating": isRating,
    "shippingSizeId": shippingSizeId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
