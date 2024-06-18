part of 'get_user_bloc.dart';

@freezed
class GetUserEvent with _$GetUserEvent {
  const factory GetUserEvent.getUser({required String uid}) = _GetUser;
}