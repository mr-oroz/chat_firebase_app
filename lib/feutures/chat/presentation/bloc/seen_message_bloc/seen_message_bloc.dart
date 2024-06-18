import 'package:bloc/bloc.dart';
import 'package:chat_app_firebase/feutures/chat/domain/repositories/i_chat_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'seen_message_event.dart';
part 'seen_message_state.dart';
part 'seen_message_bloc.freezed.dart';

@injectable
class SeenMessageBloc extends Bloc<SeenMessageEvent, SeenMessageState> {
  SeenMessageBloc(this._chatRepository) : super(const _Initial()) {
    on<_SeenMessage>((event, emit) async {
      emit(const SeenMessageState.loading());
      try {
        await _chatRepository.seenMessage(
          chatRoomId: event.chatRoomId,
          senderId: event.senderId,
        );
        emit(const SeenMessageState.success());
      } catch (e) {
        emit(SeenMessageState.error(message: e.toString()));
      }
    });
  }
  final IChatRepository _chatRepository;
}
