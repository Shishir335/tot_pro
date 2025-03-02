import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:tot_pro/models/menu_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tot_pro/screens/user_profile/controllers/user_profile_controller.dart';
import 'package:tot_pro/utils/data/core/values/app_assets.dart';
import 'package:tot_pro/utils/data/core/values/app_colors.dart';
export 'package:get/get.dart';
import '../../../main.dart';
import '../../../utils/routes/app_pages.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  void initState() {
    Get.put(UserProfileController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (controller) {
      return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
              backgroundColor: Colors.black,
              actions: [
                Obx(() {
                  return controller.checkAccountFlag.value == true
                      ? PopupMenuButton<String>(
                          iconColor: Colors.white,
                          iconSize: 20,
                          onSelected: choiceAction,
                          itemBuilder: (BuildContext context) {
                            return Constants.choices.map((String choice) {
                              return PopupMenuItem<String>(
                                value: choice,
                                child: choice == context.tr('LogOut')
                                    ? Text(context.tr('Logout'))
                                    : Text(context.tr(choice)),
                              );
                            }).toList();
                          })
                      : Container();
                })
              ],
              title: Text(context.tr('Dashboard'),
                  style: const TextStyle(color: Colors.white)),
              centerTitle: true),
          body: Obx(() {
            if (controller.checkAccountFlag.value == false) {
              return Container(
                  color: Colors.white,
                  child: Card(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                        Center(
                            child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                    controller.checkAccountMessage.value,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryColor,
                                        fontSize: 20)))),
                        const SizedBox(height: 20),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 20),
                                textStyle: const TextStyle(fontSize: 30),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0))),
                            onPressed: () {
                              localStoreSRF.clear();
                              Get.offAllNamed(Routes.LOGIN);
                            },
                            child: const Text('Retry'))
                      ])));
            } else {
              return Container(
                  color: Colors.grey.shade300,
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: Stack(children: [
                    Container(
                        height: 150,
                        padding: const EdgeInsets.only(top: 0, bottom: 40),
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(20.0),
                                bottom: Radius.circular(5.0))),
                        width: double.infinity,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(context.tr('Welcome to TOT PRO'),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20)),
                              const SizedBox(height: 5),
                              Container(
                                  height: 40,
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white),
                                  child: Image.asset(
                                    AppAssets.appLogo,
                                  ))
                            ])),
                    menuCartFetchData(context, controller)
                  ]));
            }
          }));
    });
  }

  Widget menuCartFetchData(
      BuildContext context, DashboardController controller) {
    return Obx(() => SingleChildScrollView(
          child: Column(children: [
            AnimationLimiter(
                child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: controller.menuList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(
                        top: 100, left: 5, right: 5, bottom: 0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 0.0,
                            mainAxisSpacing: 0.0),
                    itemBuilder: (BuildContext ctx, int index) {
                      MenuModel menu = controller.menuList[index];
                      return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 500),
                          delay: const Duration(milliseconds: 200),
                          child: SlideAnimation(
                              horizontalOffset: 30.0,
                              curve: Curves.easeInBack,
                              child: FadeInAnimation(
                                  child: dashboardCardUI(menu, context))));
                    })),
            Image.asset(AppAssets.appLogo, height: 90, width: 100)
          ]),
        ));
  }

  dashboardCardUI(MenuModel menu, BuildContext context) {
    return InkWell(
      onTap: () {
        if (menu.menuId == 1) {
          Get.toNamed(Routes.HOME);
        } else if (menu.menuId == 2) {
          Get.toNamed(Routes.JOBHISTORY);
        } else if (menu.menuId == 3) {
          Get.toNamed(Routes.REQUESTCALL);
        } else if (menu.menuId == 4) {
          Get.toNamed(Routes.PAYMENTTRANSACTION);
        } else if (menu.menuId == 5) {
          Get.toNamed(Routes.Category);
        } else if (menu.menuId == 6) {
          Get.toNamed(Routes.Quote);
        } else if (menu.menuId == 7) {
          Get.toNamed(Routes.Review);
        } else if (menu.menuId == 8) {
          Get.toNamed(Routes.JoinUs);
        } else if (menu.menuId == 9) {
          Get.toNamed(Routes.ContactUs);
        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                    radius: 35,
                    child: menu.icon)),
            const SizedBox(height: 10),
            Text(context.tr(menu.menuTitle!).toString(),
                maxLines: 2,
                style:
                    GoogleFonts.asar(fontWeight: FontWeight.bold, fontSize: 14),
                textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }

  void choiceAction(String choice) {
    if (choice == 'Profile') {
      Get.toNamed(Routes.USERPROFILE);
    } else if (choice == 'LogOut') {
      localStoreSRF.clear();
      Get.offAllNamed(Routes.LOGIN);
    } else if (choice == 'Account Delete Request') {
      Get.toNamed(Routes.accountDeleteRequest);
    } else if (choice == 'Settings') {
      Get.toNamed(Routes.settings);
    } else {
      Get.toNamed(Routes.CHANGEPASSWORD);
    }
  }
}

class Constants {
  static const String fund = 'Fund';
//  static const String Settings = 'Settings';
  static const String SignOut = 'Sign out';

  static List<String> choices = <String>[
    'Profile',
    'Account Delete Request',
    'Change Password',
    'Settings',
    'LogOut',
  ];
}
