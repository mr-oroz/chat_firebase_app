part of 'create_chat_room_bloc.dart';

@freezed
class CreateChatRoomEvent with _$CreateChatRoomEvent {
  const factory CreateChatRoomEvent.createChatRoom({
    required String receiverUsername,
    required String uid,
  }) = _CreateChatRoom;
}
