import 'package:chat_app_firebase/feutures/chat/domain/entities/message.dart';

abstract class ListItem {}

class MessageItemModel extends ListItem {
  final Message message;
  MessageItemModel(this.message);
}

class DateItem extends ListItem {
  final DateTime date;
  DateItem(this.date);
}
