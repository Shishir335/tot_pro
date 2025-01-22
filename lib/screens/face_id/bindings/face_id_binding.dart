
import '../controllers/face_id_controller.dart';

class FaceIdAuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FaceIdAuthController>(
      () => FaceIdAuthController(),
    );
  }
}
