import 'package:get/get.dart';
import '../../routes/app_routes.dart';

class SplashController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    _startDelay();
  }

  void _startDelay() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.offAllNamed(Routes.initial);
  }
}

  