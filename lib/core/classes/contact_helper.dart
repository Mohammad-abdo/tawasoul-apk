import 'package:flutter_contacts/contact.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:mobile_app/core/classes/permission_helper.dart';

/// Helper للتعامل مع جهات الاتصال
class ContactHelper {
  ContactHelper._();

  /// يتحقق من صلاحية جهات الاتصال
  static Future<bool> hasPermission() async {
    return PermissionHelper.checkContactPermission();
  }

  /// يطلب الصلاحية ثم يتحقق منها
  static Future<bool> ensurePermission() async {
    return PermissionHelper.requestContactPermission();
  }

  /// يفتح محدد جهات الاتصال ويعيد الجهة المُختارة
  static Future<Contact?> pickContact() async {
    try {
      return await FlutterContacts.openExternalPick();
    } catch (_) {
      return null;
    }
  }

  /// يختار جهة اتصال (بعد التحقق من الصلاحية) ويعيدها
  static Future<Contact?> pickContactWithPermission() async {
    final hasPermission = await ensurePermission();
    if (!hasPermission) return null;
    return pickContact();
  }

  /// يُنسّق جهة الاتصال كنص جاهز للمشاركة (مثال: 📇 الاسم | 0123456789)
  static String formatForShare(Contact contact) {
    final name = contact.displayName;
    final phones = contact.phones;
    final phone = phones.isNotEmpty ? phones.first.number : '';
    return '📇 $name${phone.isNotEmpty ? ' | $phone' : ''}';
  }

  /// يُنسّق جهة الاتصال كنص بسيط (اسم + رقم)
  static String formatSimple(Contact contact) {
    final name = contact.displayName;
    final phones = contact.phones;
    final phone = phones.isNotEmpty ? phones.first.number : '';
    return phone.isNotEmpty ? '$name - $phone' : name;
  }
}
