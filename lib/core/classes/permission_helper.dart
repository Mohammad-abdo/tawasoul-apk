import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';

/// Helper للتعامل مع صلاحيات: التسجيل، جهات الاتصال، التخزين/المشاركة
class PermissionHelper {
  PermissionHelper._();

  // --------------- Record (Microphone) ---------------

  /// يطلب صلاحية الميكروفون للتسجيل الصوتي
  static Future<bool> requestRecordPermission() async {
    final status = await Permission.microphone.request();
    return status.isGranted;
  }

  /// يتحقق من صلاحية الميكروفون
  static Future<bool> checkRecordPermission() async {
    final status = await Permission.microphone.status;
    return status.isGranted;
  }

  // --------------- Contact ---------------

  /// يطلب صلاحية جهات الاتصال
  static Future<bool> requestContactPermission() async {
    return FlutterContacts.requestPermission(readonly: true);
  }

  /// يتحقق من صلاحية جهات الاتصال (عبر permission_handler)
  static Future<bool> checkContactPermission() async {
    final status = await Permission.contacts.status;
    return status.isGranted;
  }

  // --------------- Storage / Share ---------------

  /// يطلب صلاحية التخزين للمشاركة ورفع الملفات
  /// على Android 13+ يطلب صلاحيات الوسائط (صور، فيديو، صوت)
  static Future<bool> requestStoragePermission() async {
    if (await Permission.storage.isGranted) return true;
    if (await Permission.photos.isGranted) return true;
    final storage = await Permission.storage.request();
    if (storage.isGranted) return true;
    final photos = await Permission.photos.request();
    return photos.isGranted;
  }

  /// يطلب صلاحيات الوسائط (صور، فيديو، صوت) للمشاركة
  static Future<bool> requestMediaPermission() async {
    final photos = await Permission.photos.request();
    final videos = await Permission.videos.request();
    final audio = await Permission.audio.request();
    return photos.isGranted || videos.isGranted || audio.isGranted;
  }

  /// يتحقق من صلاحية التخزين/الوسائط
  static Future<bool> checkStoragePermission() async {
    if (await Permission.storage.isGranted) return true;
    if (await Permission.photos.isGranted) return true;
    if (await Permission.videos.isGranted) return true;
    if (await Permission.audio.isGranted) return true;
    return false;
  }

  // --------------- General ---------------

  /// يفتح إعدادات التطبيق إذا كانت الصلاحية مرفوضة نهائياً
  static Future<void> openAppSettingsIfDenied(Permission permission) async {
    final status = await permission.status;
    if (status.isPermanentlyDenied) {
      await openAppSettings();
    }
  }

  /// يطلب الصلاحية أو يفتح الإعدادات إذا كانت مرفوضة نهائياً
  static Future<bool> requestOrOpenSettings(Permission permission) async {
    var status = await permission.status;
    if (status.isGranted) return true;
    if (status.isPermanentlyDenied) {
      await openAppSettings();
      return false;
    }
    status = await permission.request();
    return status.isGranted;
  }
}
