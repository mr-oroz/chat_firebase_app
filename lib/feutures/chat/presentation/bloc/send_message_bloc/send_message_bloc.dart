import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:chat_app_firebase/feutures/chat/domain/repositories/i_chat_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'send_message_event.dart';
part 'send_message_state.dart';
part 'send_message_bloc.freezed.dart';

@injectable
class SendMessageBloc extends Bloc<SendMessageEvent, SendMessageState> {
  SendMessageBloc(this._chatRepository) : super(const _Initial()) {
    on<_SendMessage>((event, emit) async {
      emit(const SendMessageState.loading());
      try {
        await _chatRepository.sendMessage(
          file: event.file,
          message: event.message,
          chatRoomId: event.chatRoomId,
          receiverId: event.receiverId,
        );
        emit(const SendMessageState.success());
      } catch (e) {
        emit(SendMessageState.error(message: e.toString()));
      }
    });
  }
  final IChatRepository _chatRepository;
}
