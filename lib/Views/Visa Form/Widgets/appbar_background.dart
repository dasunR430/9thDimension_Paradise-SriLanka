import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paradise_sri_lanka/Common/Widgets/curved_edges_widget.dart';
import 'package:paradise_sri_lanka/Controllers/image_switcher_controller.dart';

class FormAppBarBackground extends StatelessWidget {
  final double height;
  final Widget? child;

  const FormAppBarBackground({
    Key? key,
    required this.height,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final ImageSwitcherController controller = Get.put(ImageSwitcherController());

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: CurvedEdgesWidget(
        child: SizedBox(
          height: height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              // Background image with fade transition
              Obx(() {
                return AnimatedSwitcher(
                  duration: const Duration(seconds: 1), // Duration of the transition
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  child: Image.asset(
                    controller.images[controller.currentIndex.value],
                    key: ValueKey<int>(controller.currentIndex.value), // Key to identify different widgets
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width, // Ensure the image takes the full width
                    height: height, // Ensure the image takes the specified height
                  ),
                );
              }),
              // Overlay child widget if provided
              if (child != null) child!,
            ],
          ),
        ),
      ),
    );
  }
}
