import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'screens/detail.dart';
import 'screens/home.dart';
import 'screens/preOrder.dart';

void main() {
  runApp(
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => Home()),
          GetPage(name: '/detail', page: () => Detail()),
          GetPage(name: '/pre-order', page: () => PreOrder()),
          // GetPage(
          //     name: '/third',
          //     page: () => Third(),
          //     transition: Transition.zoom
          // ),
        ],
      )
  );
}