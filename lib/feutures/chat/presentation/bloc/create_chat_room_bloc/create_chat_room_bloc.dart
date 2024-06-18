import 'package:bloc/bloc.dart';
import 'package:chat_app_firebase/feutures/auth/domain/repositories/i_auth_repository.dart';
import 'package:chat_app_firebase/feutures/chat/domain/repositories/i_chat_repository.dart';
import 'package:chat_app_firebase/main.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/foundation.dart';

part 'create_chat_room_event.dart';
part 'create_chat_room_state.dart';
part 'create_chat_room_bloc.freezed.dart';

@injectable
class CreateChatRoomBloc
    extends Bloc<CreateChatRoomEvent, CreateChatRoomState> {
  CreateChatRoomBloc(this._chatRepository, this._authRepository)
      : super(const _Initial()) {
    on<_CreateChatRoom>((event, emit) async {
      emit(const CreateChatRoomState.loading());
      try {
        final userData = await _authRepository.getUser(uid: event.uid);
        final userMe = await _authRepository.getUser(uid: firebaseAuth.currentUser!.uid);

        final result = await _chatRepository.createChatRoom(
          receiverUsername: userData.username.toString(),
          senderUsername: userMe.username.toString(),
          uid: event.uid,
        );
        emit(CreateChatRoomState.success(chatRoomId: result));
      } catch (e) {
        emit(CreateChatRoomState.error(message: e.toString()));
      }
    });
  }
  final IAuthRepository _authRepository;
  final IChatRepository _chatRepository;
}
