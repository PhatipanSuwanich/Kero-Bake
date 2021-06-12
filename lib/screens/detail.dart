import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kero_bake/constants.dart';
import 'package:kero_bake/controllers/menuController.dart';
import 'package:kero_bake/controllers/orderController.dart';
import 'package:kero_bake/models/order.dart';

import 'widget/cart_widget.dart';

class Detail extends StatefulWidget {
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  final MenuController menuController = Get.find();
  final OrderController orderController = Get.find();
  double _currentImage = 0.0;
  int _currentSize = 0;
  double _heightImage = 250;
  int _amount = 1;
  int _price = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          imageSlider(),
          titleBar(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  detail(menuController.currentMenu().detail),
                  textHeader("ส่วนประกอบ"),
                  detail(menuController.currentMenu().ingredients),
                  textHeader("เลือกขนาด"),
                  sizeWidget(),
                  amountWidget()
                ],
              ),
            ),
          ),
          SafeArea(
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    final snackBar =
                        SnackBar(content: Text('ใส่รถเข็นเรียบร้อย!'),duration: Duration(seconds: 1)
                    );
                    setState(() {
                      orderController.addOrder(Order(
                        title: menuController.currentMenu().title,
                        cover: menuController.currentMenu().cover,
                        size: menuController.currentMenu().size[_currentSize],
                        amount: _amount,
                        price: _price,
                      ));
                    });
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  icon: Icon(Icons.shopping_cart_outlined),
                  label: Text("ใส่รถเข็น"),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      minimumSize: Size(context.width / 1.5, 50)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget imageSlider() {
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: _heightImage,
            aspectRatio: 1 / 1,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            scrollDirection: Axis.horizontal,
            enableInfiniteScroll: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentImage = index.toDouble();
              });
            },
          ),
          items: menuController.currentMenu().images.map((data) {
            return Builder(
              builder: (BuildContext context) {
                return Image.asset(data,
                    width: double.infinity, fit: BoxFit.cover);
              },
            );
          }).toList(),
        ),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 0, left: 10),
            child: BackButton(
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ),
        Container(
          height: _heightImage,
          padding: EdgeInsets.only(bottom: 5),
          alignment: Alignment.bottomCenter,
          child: DotsIndicator(
            dotsCount: menuController.currentMenu().images.length,
            position: _currentImage,
            decorator: DotsDecorator(
              size: Size.square(9.0),
              activeSize: Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          ),
        ),
        Positioned(
          right: 20,
          child: SafeArea(
            child: CartWidget(),
          ),
        ),
      ],
    );
  }

  textHeader(String text) {
    return Padding(
      padding: EdgeInsets.only(top: 5, left: 10, right: 5),
      child: Text(text, style: sizeB24),
    );
  }

  detail(String text) {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 10, right: 5),
      child: Text(text, style: size18),
    );
  }

  titleBar() {
    _price = menuController.currentMenu().price[_currentSize] * _amount;
    return Container(
      color: Colors.orange,
      width: context.width,
      padding: EdgeInsets.only(top: 5, bottom: 5, right: 10, left: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            menuController.currentMenu().title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Text(
            "฿ ${_price}",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget amountWidget() {
    return Padding(
      padding: EdgeInsets.only(top: 5, bottom: 5, right: 10, left: 10),
      child: Row(
        children: [
          Text("จำนวน", style: sizeB24),
          Spacer(),
          OutlinedButton(
            onPressed: () {
              if (_amount > 1) {
                setState(() {
                  _amount--;
                });
              }
            },
            child: Text("-", style: TextStyle(color: Colors.green)),
          ),
          OutlinedButton(
            onPressed: null,
            child: Text(
              _amount.toString(),
              style: TextStyle(color: Colors.red),
            ),
          ),
          OutlinedButton(
            onPressed: () {
              setState(() {
                _amount++;
              });
            },
            child: Text("+", style: TextStyle(color: Colors.green)),
          ),
        ],
      ),
    );
  }

  Widget sizeWidget() {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: menuController.currentMenu().size.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
            child: OutlinedButton(
              onPressed: () {
                setState(() {
                  _currentSize = index;
                });
              },
              child: Text(menuController.currentMenu().size[index]),
              style: OutlinedButton.styleFrom(
                  primary: Colors.black,
                  backgroundColor: _currentSize == index
                      ? Colors.green
                      : Colors.transparent),
            ),
          );
        },
      ),
    );
  }
}
