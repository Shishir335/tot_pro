
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tot_pro/app/data/snackbar.dart';
import 'package:tot_pro/app/routes/app_pages.dart';
import 'package:local_auth/local_auth.dart';
export 'package:get/get.dart';
import '../../../../main.dart';
import '../controllers/face_id_controller.dart';
export 'package:get/get.dart';

class FaceIdAuthController extends GetxController {
  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  final canCheckBiometrics = false.obs;
  final _availableBiometrics = <BiometricType>[].obs;
  final authorized = 'Not Authorized'.obs;
  final isAuthenticating = false.obs;
  final count = 1.obs;

  @override
  void onInit() {
    super.onInit();
    auth.isDeviceSupported().then((bool isSupported) {
      _supportState =
          isSupported ? _SupportState.supported : _SupportState.unsupported;
    });
  }



  /*Future<void> checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
      print('canCheckBiometrics :$canCheckBiometrics');
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      print(e);
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> getAvailableBiometrics() async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
      print(e);
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }
*/
  Future<void> authenticate() async {
    bool authenticated = false;
    try {
      isAuthenticating.value = true;
      authorized.value = 'Authenticating';

      authenticated = await auth.authenticate(
        localizedReason: 'Let OS determine authentication method',
        options: const AuthenticationOptions(
          stickyAuth: true,
          sensitiveTransaction: true,
          useErrorDialogs: true

        ),
      );

      isAuthenticating.value = false;
    } on PlatformException catch (e) {
      print(e);

      isAuthenticating.value = false;
      authorized.value = 'Error - ${e.message}';

      return;
    }
    /* if (!mounted) {
      return;
    }*/

    authorized.value = authenticated ? 'Authorized' : 'Not Authorized';

    if (authorized.value=='Authorized'){

      print('FaceIdAuthController.authenticate Go the Dashboard');
      successSnack('Face Id has ${authorized.value}');
     if (localStoreSRF.getString('token') != null){
    Get.offNamedUntil(Routes.DASHBOARD, (route) => false);
    }else{
       Get.toNamed(Routes.LOGIN);
     }
    }else if(authorized.value=='Not Authorized'){

      alertSnack('Face Id has ${authorized.value}');
    }else{
      errorSnack(authorized.value);
    }
  }

  Future<void> authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      isAuthenticating.value = true;
      authorized.value = 'Authenticating';

      authenticated = await auth.authenticate(
        localizedReason:
            'Scan your fingerprint (or Face ID or whatever) to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );

      isAuthenticating.value = false;
      authorized.value = 'Authenticating';
    } on PlatformException catch (e) {
      print(e);

      isAuthenticating.value = false;
      authorized.value = 'Error - ${e.message}';

      return;
    }
    /*if (!mounted) {
      return;
    }*/

    final String message = authenticated ? 'Authorized' : 'Not Authorized';

    authorized.value = message;

    if (authorized.value=='Authorized'){

      print('FaceIdAuthController.authenticate Go the Dashboard');
      successSnack('Face ID has ${authorized.value}');
      if (localStoreSRF.getString('token') != null){
        Get.offNamedUntil(Routes.DASHBOARD, (route) => false);
      }else{
        Get.toNamed(Routes.LOGIN);
      }
    }else if(authorized.value=='Not Authorized'){

      alertSnack('Face ID has ${authorized.value}');
    }else{
      errorSnack(authorized.value);
    }
  }

  Future<void> cancelAuthentication() async {
    await auth.stopAuthentication();
    isAuthenticating.value = false;
  }
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}
