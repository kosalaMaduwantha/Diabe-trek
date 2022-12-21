import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';

class GetWoundData extends StatelessWidget {
  final File image;
  
  const GetWoundData({super.key, required this.image})
  
  @override
  Widget build(BuildContext context) {
    
  }
}

Future<Uint8List> _getWoundData(File photo) async{
    const url = "/get_wound_state";
    try {
      FormData data = new FormData.fromMap({
        "image": await MultipartFile.fromFile(photo.path),
      });
      final response = await dio.post(url, data: data);

      String jsonResponse = json.decode(response.data)["img"].toString();
      List<int> bytes =
          utf8.encode(jsonResponse.substring(2, jsonResponse.length - 1));

      Uint8List dataResponse = Uint8List.fromList(bytes);

      return dataResponse;

    } catch (error) {
      print(error);
    } 
  }