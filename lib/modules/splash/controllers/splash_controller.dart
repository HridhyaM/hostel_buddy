import 'package:get/get.dart';
import 'package:hostel_buddy/app/routes/app_pages.dart';
import 'package:hostel_buddy/app/routes/app_routes.dart';

class SplashController extends GetxController {
  final RxBool showLogo = false.obs;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(milliseconds: 300), () {
      showLogo.value = true;
    });

    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed(AppRoutes.registration); // Navigate to next screen
    });
  }
}
