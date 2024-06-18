part of 'get_user_bloc.dart';

@freezed
class GetUserState with _$GetUserState {
  const factory GetUserState.initial() = _Initial;
  const factory GetUserState.loading() = _Loading;
  const factory GetUserState.error({required String message}) = _Error;
  const factory GetUserState.success({required UserProfile user}) = _Success;
}
