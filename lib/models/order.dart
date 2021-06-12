import 'package:hive/hive.dart';

part 'order.g.dart';

@HiveType(typeId: 0)
class Order extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String cover;

  @HiveField(2)
  late String size;

  @HiveField(3)
  late int amount;

  @HiveField(4)
  late int price;

  Order({required this.title,required this.cover,required this.size,required this.amount,required this.price});

  Order.fromJson(dynamic json) {
    title = json["title"];
    cover = json["cover"];
    size = json["size"];
    amount = json["amount"];
    price = json["price"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["title"] = title;
    map["cover"] = cover;
    map["size"] = size;
    map["amount"] = amount;
    map["price"] = price;
    return map;
  }
}
