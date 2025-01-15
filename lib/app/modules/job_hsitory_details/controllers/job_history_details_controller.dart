import 'package:get/get.dart';
import 'package:tot_pro/models/menu_model.dart';
import 'package:video_player/video_player.dart';

class JobHistoryDetailsController extends GetxController {
  late VideoPlayerController controllerVPlayer;
  final menuList = <MenuModel>[].obs;
  final videoPlayName =
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'
          .obs;
  late Future<void> initializeVideoPlayerFuture;

  final basename = ''.obs;
  final count = 0.obs;
  final isVideo = true.obs;
  final isPause = false.obs;

  @override
  void onClose() {
    controllerVPlayer.dispose();
    super.onClose();
  }

  @override
  void dispose() {
    controllerVPlayer.dispose();
    super.dispose();
  }
}
