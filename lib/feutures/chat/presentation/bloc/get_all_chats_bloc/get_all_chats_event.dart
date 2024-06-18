part of 'get_all_chats_bloc.dart';

@freezed
class GetAllChatsEvent with _$GetAllChatsEvent {
  const factory GetAllChatsEvent.getAllChatRoom() = _GetAllChatsRoom;
  const factory GetAllChatsEvent.searchChat({required String query}) = _SearchChat;
}