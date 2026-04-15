import 'package:intl/intl.dart';

class DateHelper {
  static String formatDate(DateTime date) =>
      DateFormat('yyyy-MM-dd').format(date);

  static String formatTime(DateTime date) => DateFormat('HH:mm').format(date);

  // DateFormat('dd/MM/yyyy').format(now);   // 06/04/2026
  // DateFormat('hh:mm a').format(now);     // 02:30 PM
  // DateFormat('EEEE').format(now);        // Monday
  // DateFormat('MMM d, yyyy').format(now); // Apr 6, 2026
}
