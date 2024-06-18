import 'package:intl/intl.dart';

String formatDateChat(DateTime date) {
  if (DateTime.now().difference(date).inDays == 0) {
    return "Сегодня";
  } else {
    return DateFormat('dd.MM.yy').format(date); // Формат для других дней
  }
}
