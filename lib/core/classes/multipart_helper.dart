// core/network/multipart_helper.dart
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MultipartHelper {
  //! upload image to api by http
  static Future<http.MultipartFile> image({
    required File file,
    String fieldName = 'image',
  }) async {
    return await http.MultipartFile.fromPath(
      fieldName,
      file.path,
      filename: basename(file.path),
    );
  }

  //! send image to api by http
  static Future<http.StreamedResponse> send({
    required String url,
    required Map<String, String> fields,
    List<http.MultipartFile>? files,
    Map<String, String>? headers,
  }) async {
    final request = http.MultipartRequest('POST', Uri.parse(url));

    if (headers != null) request.headers.addAll(headers);
    request.fields.addAll(fields);
    if (files != null) request.files.addAll(files);

    return await request.send();
  }

  //! upload image to firebase
  static Future<String> uploadImageToFirebase({
    required File image,
    required String path,
  }) async {
    final ref = FirebaseStorage.instance.ref().child(path);

    final uploadTask = await ref.putFile(image);

    final imageUrl = await uploadTask.ref.getDownloadURL();

    return imageUrl;
  }

  //! upload image to api by dio
  static Future<MultipartFile> uploadedImageToApi(XFile img) async {
    return await MultipartFile.fromFile(
      img.path,
      filename: img.path.split("/").last,
    );
  }
}
