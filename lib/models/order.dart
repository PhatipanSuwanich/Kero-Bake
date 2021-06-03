class Order {
  late String title;
  late String cover;
  late String size;
  late int amount;
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
