import 'package:bloc/bloc.dart';
import 'package:chat_app_firebase/feutures/auth/domain/entities/user_profile.dart';
import 'package:chat_app_firebase/feutures/auth/domain/repositories/i_auth_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'get_all_users_event.dart';
part 'get_all_users_state.dart';
part 'get_all_users_bloc.freezed.dart';

@injectable
class GetAllUsersBloc extends Bloc<GetAllUsersEvent, GetAllUsersState> {
  List<UserProfile>? allUsers;
  GetAllUsersBloc(this._authRepository) : super(const _Initial()) {
    on<_GetAllUsers>((event, emit) async {
      emit(const GetAllUsersState.loading());
      try {
        final result = await _authRepository.getAllUsers();
        allUsers = result;
        emit(GetAllUsersState.success(users: result));
      } catch (e) {
        emit(GetAllUsersState.error(message: e.toString()));
      }
    });
    on<_SearchUser>((event, emit) async {
      if (state is _Success && allUsers != null) {
        if (event.value.isEmpty) {
          emit(GetAllUsersState.success(users: allUsers!));
        } else {
          final filteredChatRoom = allUsers!
              .where(
                (user) => user.username!
                    .toLowerCase()
                    .contains(event.value.toLowerCase()),
              )
              .toList();
          emit(GetAllUsersState.success(users: filteredChatRoom));
        }
      }
    });
  }

  final IAuthRepository _authRepository;
}
