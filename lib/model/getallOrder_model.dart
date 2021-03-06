// To parse this JSON data, do
//
//     final adminOrder = adminOrderFromJson(jsonString);

import 'dart:convert';

List<AdminOrder> adminOrderFromJson(String str) =>
    List<AdminOrder>.from(json.decode(str).map((x) => AdminOrder.fromJson(x)));

String adminOrderToJson(List<AdminOrder> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdminOrder {
  AdminOrder({
    this.shippingAddress,
    this.id,
    this.user,
    this.orderItems,
    this.taxPrice,
    this.shippingPrice,
    this.totalPrice,
    this.isPaid,
    this.isDelivered,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  ShippingAddress? shippingAddress;
  String? id;
  User? user;
  List<OrderItem>? orderItems;
  int? taxPrice;
  int? shippingPrice;
  int? totalPrice;
  bool? isPaid;
  bool? isDelivered;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory AdminOrder.fromJson(Map<String, dynamic> json) => AdminOrder(
        shippingAddress: ShippingAddress.fromJson(json["shippingAddress"]),
        id: json["_id"],
        user: User.fromJson(json["user"]),
        orderItems: List<OrderItem>.from(
            json["orderItems"].map((x) => OrderItem.fromJson(x))),
        taxPrice: json["taxPrice"],
        shippingPrice: json["shippingPrice"],
        totalPrice: json["totalPrice"],
        isPaid: json["isPaid"],
        isDelivered: json["isDelivered"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "shippingAddress": shippingAddress?.toJson(),
        "_id": id,
        "user": user?.toJson(),
        "orderItems": List<dynamic>.from(orderItems!.map((x) => x.toJson())),
        "taxPrice": taxPrice,
        "shippingPrice": shippingPrice,
        "totalPrice": totalPrice,
        "isPaid": isPaid,
        "isDelivered": isDelivered,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class OrderItem {
  OrderItem({
    this.name,
    this.qty,
    this.image,
    this.price,
    this.product,
    this.id,
  });

  String? name;
  int? qty;
  String? image;
  int? price;
  String? product;
  String? id;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        name: json["name"],
        qty: json["qty"],
        image: json["image"],
        price: json["price"],
        product: json["product"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "qty": qty,
        "image": image,
        "price": price,
        "product": product,
        "_id": id,
      };
}

class ShippingAddress {
  ShippingAddress({
    this.address,
    this.city,
    this.postalCode,
    this.country,
  });

  String? address;
  String? city;
  String? postalCode;
  String? country;

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      ShippingAddress(
        address: json["address"],
        city: json["city"],
        postalCode: json["postalCode"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "city": city,
        "postalCode": postalCode,
        "country": country,
      };
}

class User {
  User({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}
