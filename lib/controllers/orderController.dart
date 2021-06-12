import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:kero_bake/models/order.dart';

class OrderController extends GetxController {
  final order = <Order>[].obs;

  void addOrder(Order _order) {
    var box = Hive.box<Order>('HistoryOrder');
    order.add(_order);
    box.add(_order);
  }


}
