import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Controllers/visa_application_controller.dart';

class UploadProgressOverlay extends StatelessWidget {
  final VisaApplicationController controller;

  const UploadProgressOverlay({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.uploadProgress.value > 0 &&
          controller.uploadProgress.value < 1) {
        return Container(
          color: Colors.black54,
          child: Center(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 20),
                    Text(
                        'Uploading: ${(controller.uploadProgress.value * 100).toStringAsFixed(0)}%'),
                  ],
                ),
              ),
            ),
          ),
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }
}
