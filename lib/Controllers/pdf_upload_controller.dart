import 'package:get/get.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

class PdfUploadController extends GetxController {
  var pdfFile = Rxn<File>();

  // Method to pick a PDF file
  Future<void> pickPdf() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      updatePdf(File(result.files.single.path!));
    }
  }

  // Update the PDF file
  void updatePdf(File file) {
    pdfFile.value = file;
  }

  // Clear the PDF file
  void clearPdf() {
    pdfFile.value = null;
  }
}
