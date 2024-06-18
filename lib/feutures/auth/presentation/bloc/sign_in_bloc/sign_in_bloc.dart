import 'package:bloc/bloc.dart';
import 'package:chat_app_firebase/feutures/auth/domain/repositories/i_auth_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';
part 'sign_in_bloc.freezed.dart';

@injectable
class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc(this._authRepository) : super(const _Initial()) {
    on<_Login>((event, emit) async {
      emit(const SignInState.loading());
      try {
        await _authRepository.signIn(email: event.email, password: event.password);
        emit(const SignInState.success());
      } catch (e) {
        emit(SignInState.error(message: e.toString()));
      }
    });
  }

  final IAuthRepository _authRepository;
}
