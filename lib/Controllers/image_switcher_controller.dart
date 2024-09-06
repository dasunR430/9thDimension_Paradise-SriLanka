import 'package:get/get.dart';

class ImageSwitcherController extends GetxController {
  final RxInt currentIndex = 0.obs;
  final List<String> images = [
    "assets/images/formbackground1.png",
    "assets/images/formbackground2.png",
    "assets/images/formbackground3.png",
  ];

  @override
  void onInit() {
    super.onInit();
    // Start the image switching
    switchImage();
  }

  void switchImage() {
    Future.delayed(const Duration(seconds: 10), () {
      currentIndex.value = (currentIndex.value + 1) % images.length;
      switchImage(); // Recursive call to continue switching
    });
  }
}
