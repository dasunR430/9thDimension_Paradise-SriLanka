import 'package:get/get.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:paradise_sri_lanka/Controllers/applicants_controller.dart';
import 'package:paradise_sri_lanka/Controllers/visa_application_controller.dart';

class PdfUploadController extends GetxController {
  var pdfFile = Rxn<File>();

  // Method to pick a PDF file
  Future<void> pickPdf(String type) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      updatePdf(File(result.files.single.path!));
      VisaApplicationController applicantController = Get.find();
      if(type=="return"){
        applicantController.returnAirTicketURLController.value.text = result.files.single.path!;
      }else{
        applicantController.accommodationPlaceDocumentURLController.value.text = result.files.single.path!;
      }
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
