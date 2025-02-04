import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils/routes/app_pages.dart';

late SharedPreferences localStoreSRF;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  localStoreSRF = await SharedPreferences.getInstance();

  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en', 'US'), Locale('ro', 'RO')],
        path: 'assets/langs',
        fallbackLocale: const Locale('en', 'US'),
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      title: "TOT PRO",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      // home: MyHomePage(title: 'Gallery Testing ',),
    );
  }
}
