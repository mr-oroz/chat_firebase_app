import 'package:bloc/bloc.dart';
import 'package:chat_app_firebase/feutures/auth/domain/entities/user_profile.dart';
import 'package:chat_app_firebase/feutures/auth/domain/repositories/i_auth_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'get_user_event.dart';
part 'get_user_state.dart';
part 'get_user_bloc.freezed.dart';

@injectable
class GetUserBloc extends Bloc<GetUserEvent, GetUserState> {
  GetUserBloc(this._authRepository) : super(const _Initial()) {
    on<_GetUser>((event, emit) async {
      emit(const GetUserState.loading());
      try {
        final result = await _authRepository.getUser(uid: event.uid);
        emit(GetUserState.success(user: result));
      } catch (e) {
        emit(GetUserState.error(message: e.toString()));
      }
    });
  }
  final IAuthRepository _authRepository;
}
