import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:tot_pro/models/menu_model.dart';
import 'package:google_fonts/google_fonts.dart';
export 'package:get/get.dart';
import '../../../../main.dart';
import '../../../routes/app_pages.dart';
import '../controllers/dashboard_controller.dart';

enum menuItem {
  LogOut,
  Profile,
}

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    String register = localStoreSRF.getString('register') ?? '';
    print('DashboardView.build register:: $register');

    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            backgroundColor: Colors.black,
            actions: [
              Obx(() {
                print(
                    'DashboardView.build ${controller.count.value.toString()}');
                return controller.checkAccountFlag.value == true
                    ? PopupMenuButton<String>(
                        iconColor: Colors.white,
                        iconSize: 20,
                        onSelected: choiceAction,
                        itemBuilder: (BuildContext context) {
                          return Constants.choices.map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: choice == 'LogOut'
                                  ? const Text('Logout')
                                  : Text(choice),
                            );
                          }).toList();
                        })
                    : Container();
              })
            ],
            title:
                const Text('Dashboard', style: TextStyle(color: Colors.white)),
            centerTitle: true),
        body: Obx(() {
          print('checkAccount ${controller.checkAccountFlag.value}');
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
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                              fontSize: 20),
                        ),
                      )),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            //backgroundColor: Colors.red,
                            //minimumSize: const Size(80, 20),
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            textStyle: const TextStyle(
                              fontSize: 30,
                              // color: Colors.red
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                          ),
                          onPressed: () {
                            print('SignOut');
                            print(localStoreSRF.getString('token'));
                            print('SignOut clear');
                            localStoreSRF.clear();
                            print(localStoreSRF.getString('token'));
                            Get.offAllNamed(Routes.LOGIN);
                          },
                          child: const Text('Retry'))
                    ],
                  ),
                ));
          } else {
            return Container(
                color: Colors.grey.shade300,
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Stack(children: [
                  Container(
                      height: 150,
                      padding: const EdgeInsets.only(top: 0, bottom: 40),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20.0),
                          bottom: Radius.circular(5.0),
                        ),
                      ),
                      width: double.infinity,
                      child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Welcome to EDGE',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),

                            /* Column(
                    children: [
                      CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 20,
                          child: Icon(
                            Icons.settings,
                            size: 20,
                            color: Colors.red,
                          )),
                      Text(
                        'Settings',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      )
                    ],
                  )*/
                          ])),
                  menuCartFetchData(context)
                ]));
          }
        }));
  }

  Widget menuCartFetchData(BuildContext context) {
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
            Image.asset("assets/images/splogo.png",
                fit: BoxFit.cover, height: 90, width: 100)
          ]),
        ));
  }

  dashboardCardUI(MenuModel menu, context) {
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
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: CircleAvatar(
                  backgroundColor: Colors.grey.shade200,
                  radius: 35,
                  child: menu.icon),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              menu.menuTitle.toString(),
              maxLines: 2,
              style:
                  GoogleFonts.asar(fontWeight: FontWeight.bold, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void choiceAction(String choice) {
    print('choice :$choice');
    if (choice == 'Profile') {
      print('My Profile');
      Get.toNamed(Routes.USERPROFILE);
    } else if (choice == 'LogOut') {
      print('SignOut');
      print(localStoreSRF.getString('token'));
      print('SignOut clear');
      localStoreSRF.clear();
      print(localStoreSRF.getString('token'));
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

  static const List<String> choices = <String>[
    'Profile',
    'Account Delete Request',
    'Change Password',
    'Settings',
    'LogOut',
  ];
}
