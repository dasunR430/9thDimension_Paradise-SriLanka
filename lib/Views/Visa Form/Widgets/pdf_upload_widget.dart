import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Controllers/pdf_upload_controller.dart';

class PdfUploadWidget extends StatelessWidget {
  final String instructionText;
  final PdfUploadController controller;
  final String questionText;
  final bool isRequired;
  final String type;

  const PdfUploadWidget({
    super.key,
    required this.instructionText,
    required this.controller,
    required this.questionText,
    required this.type,
    this.isRequired = false,
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

        const SizedBox(height: 10,),

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
              if (controller.pdfFile.value != null) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.picture_as_pdf,
                      size: 80.0,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'PDF document uploaded: ${controller.pdfFile.value!.path.split('/').last}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () => controller.pickPdf(type),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue,
                      ), // Change or re-upload PDF
                      child: const Text('Change PDF document'),
                    ),
                  ],
                );
              } else {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.picture_as_pdf,
                      size: 50.0,
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
                      onPressed: () => controller.pickPdf(type), // Upload PDF
                      icon: const Icon(Icons.upload_file),
                      label: const Text('Upload PDF document'),
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
