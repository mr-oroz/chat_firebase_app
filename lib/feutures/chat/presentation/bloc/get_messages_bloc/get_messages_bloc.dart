import 'package:bloc/bloc.dart';
import 'package:chat_app_firebase/feutures/chat/domain/entities/message.dart';
import 'package:chat_app_firebase/feutures/chat/domain/repositories/i_chat_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'get_messages_event.dart';
part 'get_messages_state.dart';
part 'get_messages_bloc.freezed.dart';

@injectable
class GetMessagesBloc extends Bloc<GetMessagesEvent, GetMessagesState> {
  GetMessagesBloc(this._chatRepository) : super(const _Initial()) {
    on<_GetMessages>((event, emit) async {
      emit(const GetMessagesState.loading());
      try {
        await for (final messages
            in _chatRepository.getMessages(chatRoomId: event.chatRoomId)) {
          emit(GetMessagesState.success(messages));
        }
      } catch (e) {
        emit(GetMessagesState.error(message: e.toString()));
      }
    });
    on<_AddNewMessage>((event, emit) async {
      state.maybeWhen(
        success: (messages) {
          final data = [event.message, ...messages];
          emit(GetMessagesState.success(data));
        },
        orElse: () {},
      );
    });
  }
  final IChatRepository _chatRepository;
}
