import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:paradise_sri_lanka/Services/API/Exceptions/database_exception.dart';
import 'dart:io';
import 'package:path/path.dart';

class ParadiseHelper{

  static const String _baseurl = 'http://192.168.8.115:3000/api/data';

  static Map<String, String> getDetailsFromPassprt(File imageFile){
    String url = '$_baseurl/passportdata';
    try {
      uploadImage(url, imageFile);
    } catch (e) {
      print('Error occurred while getting details from passport: $e');
    }
    dynamic details = uploadImage(url, imageFile);
    return {
      //TODO: Add the details to the map
    };
  }


  static Future<dynamic> uploadImage(String url, File file) async {
    var uri = Uri.parse(url);

    var request = http.MultipartRequest('POST', uri);


    var multipartFile = await http.MultipartFile.fromPath(
      'image',
      file.path,
      filename: basename(file.path),
    );

    request.files.add(multipartFile);

    try {

      var streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 201) {
        print('File uploaded successfully!');
        return jsonDecode(response.body);
      } else {
        print('File upload failed with status: ${response.statusCode}');
        throw DataBaseException('File upload failed');
      }
    } catch (e) {
      print('Error occurred while uploading file: $e');
      throw DataBaseException('Error occurred while uploading file');
    }
  }

}
