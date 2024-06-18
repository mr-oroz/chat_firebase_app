import 'package:chat_app_firebase/feutures/chat/domain/entities/message.dart';
import 'package:chat_app_firebase/feutures/chat/domain/entities/message_item_model.dart';

List<ListItem> buildItems(List<Message> messages) {
  List<ListItem> items = [];
  DateTime? lastDate;
  List<MessageItemModel> dayMessages = [];

  for (var message in messages) {
    DateTime messageDate = message.timestamp!.toDate();
    messageDate = DateTime(messageDate.year, messageDate.month, messageDate.day);
    if (lastDate != null && messageDate != lastDate) {
      items.addAll(dayMessages); 
      items.add(DateItem(lastDate)); 
      dayMessages = []; 
    }

    dayMessages.add(MessageItemModel(message));
    lastDate = messageDate;
  }

  if (dayMessages.isNotEmpty) {
    items.addAll(dayMessages);
    if (lastDate != null) {
      items.add(DateItem(lastDate));
    }
  }

  return items;
}
