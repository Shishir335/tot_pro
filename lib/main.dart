import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils/routes/app_pages.dart';

late SharedPreferences localStoreSRF;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  localStoreSRF = await SharedPreferences.getInstance();
  runApp(
    GetMaterialApp(
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      title: "EDGE",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      // home: MyHomePage(title: 'Gallery Testing ',),
    ),
  );
}
