

import 'package:flutter/material.dart';
import 'package:tot_pro/app/data/core/values/app_space.dart';
export 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../controllers/face_id_controller.dart';


class FaceIdAuthView extends GetView<FaceIdAuthController> {
  const FaceIdAuthView({super.key});


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      //backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Face ID'),
      ),
      body: Obx((){
        print('FaceIdAuthView.build ${controller.count.value}');
        return  ListView(
          padding: const EdgeInsets.only(top: 30,left: 10,right: 10),
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                const SizedBox(
                  height: 20,
                ),

                const Text('Unlock with your Face ID ',
                 style: TextStyle(fontWeight: FontWeight.bold,
                 color: Colors.black,
                   fontSize: 18,


                 ),
                ),
                const SizedBox(
                  height: 20,
                ),


              /*  Center(
                  child: Text(
                    'Use Face ID to unlock remember or type in your master password',
                  ),
                ),*/

                Text(
                  'Current State: ${controller.authorized}\n',
                ),
                // Icon(

                const SizedBox(
                  height: 20,
                ),
                //  Image.asset('assets/images/face-recognition.gif'),

                controller.authorized == 'Authenticating'
                    ? Image.asset(
                  'assets/faceid/faceloading.gif',
                  height: 200,
                  width: 200,
                )
                    : controller. authorized == 'Authorized'
                    ? Image.asset(
                  'assets/faceid/facebefore.jpeg',
                  height: 200,
                  width: 200,
                )
                    : Image.asset(
                  'assets/faceid/face-id.png',
                  height: 100,
                  width: 100,
                ),
                const SizedBox(
                  height: 100,
                ),

                Column(
                  children: <Widget>[
                    InkWell(
                      onTap: (){
                        controller.authenticateWithBiometrics();
                      },
                      child: Container(
                        width: double.maxFinite,
                        margin: const EdgeInsets.all(10),
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                            child: Text(
                              "USE FACE ID".toUpperCase(),
                              style: const TextStyle(fontSize: 18, color: Colors.white),
                            )),
                      ),
                    ),

                    InkWell(
                      onTap: (){controller.authenticate();},
                      child: Container(
                        width: double.maxFinite,
                        margin: const EdgeInsets.all(10),
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                            child: Text(
                              "Password".toUpperCase(),
                              style: const TextStyle(fontSize: 18, color: Colors.white),
                            )),
                      ),
                    ),

                    AppSpace.spaceH8,
                    InkWell(
                      onTap: (){
                        Get.offNamedUntil(Routes.LOGIN, (route) => false);
                      },
                      child: const Text(
                        ' Back To The Login',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),

                      /*ElevatedButton(
                      onPressed: controller.authenticate,
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text('PassCode'),

                        ],
                      ),
                    ),*/
                 /*   ElevatedButton(
                      onPressed: controller.authenticateWithBiometrics,
                      child:   Text(controller.isAuthenticating.value ? 'Cancel' : 'Face ID'),

                    ),*/

                    /*ElevatedButton(
                      onPressed: (){
                        if (localStoreSRF.getString('token') != null){
                          Get.offNamedUntil(Routes.DASHBOARD, (route) => false);
                        }else{
                          Get.toNamed(Routes.LOGIN);
                        }
                      },
                      child:   Text('Dashboard'),

                    ),
                  */],
                ),
              ],
            ),
          ],
        );
      })


    );



  }

  faceUI() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Text(
            'Allow sign in with Face ID ?',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 50,
          ),
          const Icon(
            Icons.face,
            size: 150,
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: () {}, // _authenticateWithBiometrics,
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(' Face ID'),
                SizedBox(
                  width: 20,
                ),
                Icon(Icons.fingerprint),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Text('Maybe later'),
        ],
      ),
    );
  }
}

