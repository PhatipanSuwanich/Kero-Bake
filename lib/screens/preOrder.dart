import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kero_bake/controllers/orderController.dart';

class PreOrder extends StatefulWidget {
  @override
  _PreOrderState createState() => _PreOrderState();
}

class _PreOrderState extends State<PreOrder> {
  final OrderController orderController = Get.find();
  int _price = 0;

  @override
  void initState() {
    super.initState();
    orderController.order.forEach((element) {
      _price += element.price;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('รถเข็น'),
      ),
      body: orderController.order.length == 0 ? noOrder() : order(),
    );
  }

  Widget noOrder() {
    return Column(
      // mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: Icon(Icons.remove_shopping_cart_rounded,
                size: 100, color: Colors.red)),
        SizedBox(height: 10),
        Center(
            child: Text(
          "รถเข็นว่าง",
          style: TextStyle(fontSize: 24, color: Colors.red),
        )),
      ],
    );
  }

  Widget order() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: orderController.order.length,
            itemBuilder: (context, index) {
              return listorder(index);
            },
          ),
        ),
        SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(child: Text("ราคารวมทั้งหมด ฿${_price.toString()}")),
              // Spacer(),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("จ่ายเงิน"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    minimumSize: Size(100,50)
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget listorder(int index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              orderController.order[index].cover,
              fit: BoxFit.cover,
              height: 80,
              width: 80,
            ),
            SizedBox(width: 10),
            SizedBox(
              height: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(orderController.order[index].title),
                  Text("฿" + orderController.order[index].price.toString()),
                  Text(
                      "ขนาด ${orderController.order[index].size} จำนวน ${orderController.order[index].amount}"),
                ],
              ),
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.delete_forever_outlined, color: Colors.red),
              onPressed: () {
                setState(() {
                  _price -= orderController.order[index].price;
                  orderController.order.removeAt(index);
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
