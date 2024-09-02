import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

class ImageFormat{

  static Future<File?> pickImageFromGallery() async{
    final selectedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (selectedImage == null) return null;
    return File (selectedImage.path);
  }

  static String encodeFileToBase64(File imageFile){
    List<int> imageBytes = imageFile.readAsBytesSync();
    return base64Encode(imageBytes);
  }
  static String encodeBytesToBase64(List<int> imageBytes){
    return base64Encode(imageBytes);
  }

  static Uint8List decodeBase64String(String imageString){
    return base64Decode(imageString);
  }

  static Future<Uint8List?> compressFile(File file) async {
    var result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      minWidth: 2300,
      minHeight: 1500,
      quality: 50,
    );
    return result;
  }

}