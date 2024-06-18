import 'package:bloc/bloc.dart';
import 'package:chat_app_firebase/feutures/chat/domain/entities/chat_room.dart';
import 'package:chat_app_firebase/feutures/chat/domain/repositories/i_chat_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'get_all_chats_event.dart';
part 'get_all_chats_state.dart';
part 'get_all_chats_bloc.freezed.dart';

@injectable
class GetAllChatsBloc extends Bloc<GetAllChatsEvent, GetAllChatsState> {
  List<ChatRoom>? allChatRoom;
  GetAllChatsBloc(this._chatRepository) : super(const _Initial()) {
    on<_GetAllChatsRoom>((event, emit) async {
      emit(const GetAllChatsState.loading());
      final streamResponse = _chatRepository.getAllChats();
      await for (final chats in streamResponse) {
        allChatRoom = chats;
        emit(GetAllChatsState.success(chats));
      }
    });
    on<_SearchChat>((event, emit) async {
      if (state is _Success && allChatRoom != null) {
        if (event.query.isEmpty) {
          emit(GetAllChatsState.success(allChatRoom!));
        } else {
          final filteredChatRoom = allChatRoom!
              .where((room) =>
                  room.receiverUsername!
                      .toLowerCase()
                      .contains(event.query.toLowerCase()) ||
                  room.senderUsername!
                      .toLowerCase()
                      .contains(event.query.toLowerCase()))
              .toList();
          emit(GetAllChatsState.success(filteredChatRoom));
        }
      }
    });
  }
  final IChatRepository _chatRepository;
}
