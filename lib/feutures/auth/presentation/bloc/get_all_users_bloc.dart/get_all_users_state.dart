part of 'get_all_users_bloc.dart';

@freezed
class GetAllUsersState with _$GetAllUsersState {
  const factory GetAllUsersState.initial() = _Initial;
  const factory GetAllUsersState.loading() = _Loading;
  const factory GetAllUsersState.error({required String message}) = _Error;
  const factory GetAllUsersState.success({required List<UserProfile> users}) =
      _Success;
}
