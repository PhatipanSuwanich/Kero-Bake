class Menu {
  late String title;
  late String cover;
  late List<String> images;
  late String detail;
  late String ingredients;
  late List<String> size;
  late List<int> price;

  Menu(
      {required this.title,
      required this.cover,
      required this.images,
      required this.detail,
      required this.ingredients,
      required this.size,
      required this.price});

  Menu.fromJson(dynamic json) {
    title = json["title"];
    cover = json["cover"];
    images = json["images"] != null ? json["images"].cast<String>() : [];
    detail = json["detail"];
    ingredients = json["ingredients"];
    size = json["size"] != null ? json["size"].cast<String>() : [];
    price = json["price"] != null ? json["price"].cast<int>() : [];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["title"] = title;
    map["cover"] = cover;
    map["images"] = images;
    map["detail"] = detail;
    map["ingredients"] = ingredients;
    map["size"] = size;
    map["price"] = price;
    return map;
  }
}
