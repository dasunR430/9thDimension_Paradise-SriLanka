import 'dart:io';

import 'package:flutter/material.dart';
import 'package:paradise_sri_lanka/Services/API/helper.dart';
import 'package:paradise_sri_lanka/Utils/helpers/image_format.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(onPressed: () async{
        File? imageFile = await ImageFormat.pickImageFromGallery();
        Map<String, String> details = ParadiseHelper.getDetailsFromPassprt(imageFile!);
        print(details);
            }, child: const Text('Test API')),
    );
  }
}
