import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../../../Controllers/image_upload_controller.dart';

class ImageUploadWidget extends StatelessWidget {
  final String instructionText;
  final ImageUploadController controller;
  final bool isRequired;
  final String questionText;

  ImageUploadWidget({
    super.key,
    required this.instructionText,
    required this.controller,
    this.isRequired = false,
    required this.questionText,
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

        SizedBox(height: 10,),

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
                      onPressed: () => controller.pickImage(), // Call pickImage from controller
                      child: const Text('Change image'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue,
                      ),
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
                      onPressed: () => controller.pickImage(), // Call pickImage from controller
                      icon: const Icon(Icons.photo_camera),
                      label: const Text('Upload image'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 10),
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
