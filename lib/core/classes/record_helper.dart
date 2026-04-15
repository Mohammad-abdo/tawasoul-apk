import 'package:mobile_app/core/classes/permission_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

/// Helper للتعامل مع التسجيل الصوتي
class RecordHelper {
  RecordHelper._();

  static final _recorder = AudioRecorder();

  /// يتحقق من صلاحية التسجيل (يستخدم PermissionHelper)
  static Future<bool> hasPermission() async {
    return PermissionHelper.checkRecordPermission();
  }

  /// يطلب الصلاحية ثم يتحقق منها
  static Future<bool> ensurePermission() async {
    return PermissionHelper.requestRecordPermission();
  }

  /// يُنشئ مساراً مؤقتاً لملف التسجيل
  static Future<String> getRecordPath() async {
    final dir = await getTemporaryDirectory();
    return '${dir.path}/voice_${DateTime.now().millisecondsSinceEpoch}.m4a';
  }

  /// يبدأ التسجيل في المسار المُعطى
  static Future<bool> start({String? path}) async {
    final recordPath = path ?? await getRecordPath();
    try {
      await _recorder.start(const RecordConfig(), path: recordPath);
      return true;
    } catch (_) {
      return false;
    }
  }

  /// يوقف التسجيل ويعيد مسار الملف
  static Future<String?> stop() async {
    try {
      return await _recorder.stop();
    } catch (_) {
      return null;
    }
  }

  /// يلغي التسجيل دون حفظ
  static Future<void> cancel() async {
    await _recorder.cancel();
  }

  /// يتحقق إن كان التسجيل جارياً
  static Future<bool> isRecording() async {
    return _recorder.isRecording();
  }
}
