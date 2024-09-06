import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paradise_sri_lanka/Services/API/authenticate.dart';
import 'package:paradise_sri_lanka/Services/API/helper.dart';
import 'package:paradise_sri_lanka/Utils/helpers/helper_functions.dart';
import 'package:paradise_sri_lanka/Utils/helpers/image_format.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(onPressed: () async{
        File? imageFile = await ImageFormat.pickImageFromGallery();
        if(imageFile != null){
          Map<String, String> details = ParadiseHelper.getDetailsFromPassprt(imageFile);
          print(details);
        }
      }, child: Text('Test API')),
    );
  }
}
