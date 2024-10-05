import 'package:get/get.dart';
import 'package:paradise_sri_lanka/Views/Visa%20Portal/visa_portal_screen.dart';

class HomeController extends GetxController {

  static HomeController get instance => Get.find();

  void onApplyVisaPressed() {
    Get.to(() => const VisaPortalScreen());
  }

}