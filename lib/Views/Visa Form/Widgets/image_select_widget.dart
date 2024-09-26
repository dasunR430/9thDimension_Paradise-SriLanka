import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paradise_sri_lanka/Controllers/image_select_controller.dart';
import 'package:paradise_sri_lanka/Controllers/visa_application_controller.dart';

class ImageSelectWidget extends StatelessWidget {
  final String instructionText;
  final ImageSelectController controller;
  final bool isRequired;
  final String questionText;
  final String type;
  final VisaApplicationController section;

  const ImageSelectWidget({
    super.key,
    required this.instructionText,
    required this.controller,
    this.isRequired = false,
    required this.questionText,
    required this.type,
    required this.section,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              questionText,
              style: const TextStyle(fontSize: 16),
            ),
            if (isRequired)
              const Text(
                ' *',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          height: 250,
          width: MediaQuery.of(context).size.width - 20,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Center(
            child: Obx(() {
              if (controller.imageFile.value != null) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.file(
                      controller.imageFile.value!,
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 8.0),
                    ElevatedButton(
                      onPressed: () => controller.pickImage(section),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue,
                      ),
                      child: const Text('Change image'),
                    ),
                  ],
                );
              } else {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.document_scanner,
                      size: 80.0,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      instructionText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton.icon(
                      onPressed: () => controller.pickImage(section),
                      icon: const Icon(Icons.photo_camera),
                      label: const Text('Upload image'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue,
                      ),
                    ),
                  ],
                );
              }
            }),
          ),
        ),
      ],
    );
  }
}
