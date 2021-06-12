import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kero_bake/models/order.dart';
import 'screens/detail.dart';
import 'screens/home.dart';
import 'screens/preOrder.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(OrderAdapter());
  await Hive.openBox<Order>("HistoryOrder");

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    getPages: [
      GetPage(name: '/', page: () => Home()),
      GetPage(name: '/detail', page: () => Detail()),
      GetPage(name: '/pre-order', page: () => PreOrder()),
      // GetPage(name: '/web3', page: () => Web3()),
    ],
  ));
}
