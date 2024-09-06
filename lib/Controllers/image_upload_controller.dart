import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageUploadController extends GetxController {
  var imageFile = Rxn<File>();

  // Method to pick an image from the gallery
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      updateImage(File(pickedFile.path));  // Directly call updateImage method
    }
  }
  // Update the image file
  void updateImage(File file) {
    imageFile.value = file;
  }

  // Clear the image file
  void clearImage() {
    imageFile.value = null;
  }
}
