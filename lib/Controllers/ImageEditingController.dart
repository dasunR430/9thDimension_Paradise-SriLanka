import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';

class ImageEditingController extends ChangeNotifier {
  Uint8List? _imageBytes;
  File? _imageFile;
  Uri? _url;

  // Getter for image as Uint8List
  Uint8List? get imageBytes => _imageBytes;

  // Getter for image as File
  File? get imageFile => _imageFile;

  Uri? get url => _url;

  // Setter for image as Uint8List
  void setImageBytes(Uint8List? bytes) {
    _imageBytes = bytes;
    notifyListeners();
  }

  // Setter for image as File
  void setImageFile(File? file) {
    _imageFile = file;
    notifyListeners();
  }

  void setImageUrl(Uri? url) {
    _url = url;
    notifyListeners();
  }

  // Clear the image data
  void clear() {
    _imageBytes = null;
    _imageFile = null;
    _url = null;
    notifyListeners();
  }
}
