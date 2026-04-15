import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/core/classes/my_logger.dart';

class ImagesManager {
  static Future<XFile?> pickImage(ImageSource source) async {
    try {
      ImagePicker imagePicker = ImagePicker();
      XFile? file = await imagePicker.pickImage(
        source: source,
        maxWidth: source == ImageSource.camera ? 1080 : null,
        maxHeight: source == ImageSource.camera ? 1920 : null,
        imageQuality: source == ImageSource.camera ? 50 : null,
        requestFullMetadata: source == ImageSource.camera ? false : true,
      );
      if (file != null) {
        return file;
      }
      if (kDebugMode) {
        MyLogger.instance.printLog("no image found");
      }
      return null;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<XFile>?> pickImages(ImageSource source) async {
    try {
      ImagePicker imagePicker = ImagePicker();
      List<XFile>? files = await imagePicker.pickMultiImage(
        maxWidth: source == ImageSource.camera ? 1080 : null,
        maxHeight: source == ImageSource.camera ? 1920 : null,
        imageQuality: source == ImageSource.camera ? 50 : null,
        requestFullMetadata: source == ImageSource.camera ? false : true,
      );
      if (files.isNotEmpty) {
        return files;
      }
      if (kDebugMode) {
        MyLogger.instance.printLog("no image found");
      }
      return null;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// يفتح الكاميرا أو الجاليري لاختيار فيديو
  static Future<XFile?> pickVideo(ImageSource source) async {
    try {
      final imagePicker = ImagePicker();
      final file = await imagePicker.pickVideo(source: source);
      if (file != null) return file;
      if (kDebugMode) MyLogger.instance.printLog("no video found");
      return null;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// يفتح محدد الملفات لاختيار ملف (أي نوع)
  static Future<FilePickerResult?> pickFile({
    bool allowMultiple = false,
    FileType type = FileType.any,
    List<String>? allowedExtensions,
  }) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: allowMultiple,
        type: type,
        allowedExtensions: allowedExtensions,
      );
      return result;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<Uint8List?> pickStorage(ImageSource source) async {
    try {
      ImagePicker imagePicker = ImagePicker();
      XFile? file = await imagePicker.pickImage(
        source: source,
        maxWidth: source == ImageSource.camera ? 1080 : null,
        maxHeight: source == ImageSource.camera ? 1920 : null,
        imageQuality: source == ImageSource.camera ? 50 : null,
        requestFullMetadata: source == ImageSource.camera ? false : true,
      );
      if (file != null) {
        Uint8List image = await file.readAsBytes();
        return image;
      }
      if (kDebugMode) {
        MyLogger.instance.printLog("no image found");
      }
      return null;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
