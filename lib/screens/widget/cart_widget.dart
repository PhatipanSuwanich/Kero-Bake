import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kero_bake/controllers/orderController.dart';

class CartWidget extends StatefulWidget {
  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  final OrderController orderController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(()=>Badge(
          showBadge: orderController.order.length == 0 ? false : true,
          badgeContent: Text(orderController.order.length.toString()),
          child: IconButton(
            icon: Icon(Icons.shopping_cart_outlined, size: 30),
            onPressed: () {
              Get.toNamed('/pre-order');
            },
          ),
        ),
      ),
    );
  }
}