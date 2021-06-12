import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:kero_bake/constants.dart';
import 'package:kero_bake/controllers/menuController.dart';
import 'package:kero_bake/controllers/orderController.dart';
import 'package:kero_bake/models/menu.dart';
import 'package:kero_bake/models/order.dart';
import 'package:kero_bake/services/mockJson.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'widget/cart_widget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String logo = "assets/images/logo.png";

  final menuController = Get.put(MenuController());
  final orderController = Get.put(OrderController());

  @override
  void initState() {
    super.initState();
    menuController.menu.value =
        mockJsonMenu.map((e) => Menu.fromJson(e)).toList();

    var box = Hive.box<Order>('HistoryOrder');
    if(box.isNotEmpty){
      orderController.order.value = box.values.toList().cast<Order>();
    }
  }

  @override
  Widget build(BuildContext context) {
    var deviceType = getDeviceType(MediaQuery.of(context).size);

    double widthButton = 0;
    switch (deviceType) {
      case DeviceScreenType.desktop:
        widthButton = 300.0;
        break;
      case DeviceScreenType.tablet:
        widthButton = 400.0;
        break;
      case DeviceScreenType.mobile:
        widthButton = context.width;
        break;
    }

    return Scaffold(
      body: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: context.height,
              aspectRatio: 1 / 1,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              scrollDirection: Axis.vertical,
              enableInfiniteScroll: false,
              onPageChanged: (index, reason) {
                menuController.updateImage(index);
              },
            ),
            items: menuController.menu.map((data) {
              return Builder(
                builder: (BuildContext context) {
                  return Image(
                    image: AssetImage(data.cover),
                    height: context.height,
                    width: context.width,
                    fit: BoxFit.cover,
                  );
                },
              );
            }).toList(),
          ),
          Positioned(
            top: 5,
            left: 15,
            child: SafeArea(
                child: Image(
              image: AssetImage(logo),
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            )),
          ),
          Positioned(
            top: 12,
            right: 20,
            child: CartWidget()
          ),
          SafeArea(
            child: Container(
              margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed('/detail');
                },
                child: Text(
                  "CUSTOM ORDER",
                  style: size18,
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.black26,
                  padding: EdgeInsets.all(20),
                  minimumSize: Size(widthButton, 70),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
