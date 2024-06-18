import 'package:bloc/bloc.dart';
import 'package:chat_app_firebase/feutures/chat/domain/repositories/i_chat_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/foundation.dart';

part 'create_chat_room_event.dart';
part 'create_chat_room_state.dart';
part 'create_chat_room_bloc.freezed.dart';

@injectable
class CreateChatRoomBloc extends Bloc<CreateChatRoomEvent, CreateChatRoomState> {
  CreateChatRoomBloc(this._chatRepository) : super(const _Initial()) {
    on<_CreateChatRoom>((event, emit) async {
      emit(const CreateChatRoomState.loading());
      try {
        final result = await _chatRepository.createChatRoom(receiverUsername: event.receiverUsername, uid: event.uid);
        emit(CreateChatRoomState.success(chatRoomId: result));
      } catch (e) {
        emit(CreateChatRoomState.error(message: e.toString()));
      }
    });
  }
  final IChatRepository _chatRepository;
}
