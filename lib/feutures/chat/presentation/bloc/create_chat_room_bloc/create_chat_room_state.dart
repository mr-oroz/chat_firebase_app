part of 'create_chat_room_bloc.dart';

@freezed
class CreateChatRoomState with _$CreateChatRoomState {
  const factory CreateChatRoomState.initial() = _Initial;
  const factory CreateChatRoomState.success({required String chatRoomId}) = _Success;
  const factory CreateChatRoomState.loading() = _Loading;
  const factory CreateChatRoomState.error({required String message}) = _Error;
}
