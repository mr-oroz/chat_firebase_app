// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:chat_app_firebase/feutures/auth/data/firebase_auth_repository.dart'
    as _i14;
import 'package:chat_app_firebase/feutures/auth/domain/repositories/i_auth_repository.dart'
    as _i13;
import 'package:chat_app_firebase/feutures/auth/presentation/bloc/get_all_users_bloc.dart/get_all_users_bloc.dart'
    as _i15;
import 'package:chat_app_firebase/feutures/auth/presentation/bloc/get_user_bloc/get_user_bloc.dart'
    as _i16;
import 'package:chat_app_firebase/feutures/auth/presentation/bloc/sign_in_bloc/sign_in_bloc.dart'
    as _i17;
import 'package:chat_app_firebase/feutures/chat/data/firebase_chat_repository.dart'
    as _i7;
import 'package:chat_app_firebase/feutures/chat/domain/repositories/i_chat_repository.dart'
    as _i6;
import 'package:chat_app_firebase/feutures/chat/presentation/bloc/create_chat_room_bloc/create_chat_room_bloc.dart'
    as _i9;
import 'package:chat_app_firebase/feutures/chat/presentation/bloc/get_all_chats_bloc/get_all_chats_bloc.dart'
    as _i12;
import 'package:chat_app_firebase/feutures/chat/presentation/bloc/get_messages_bloc/get_messages_bloc.dart'
    as _i11;
import 'package:chat_app_firebase/feutures/chat/presentation/bloc/seen_message_bloc/seen_message_bloc.dart'
    as _i10;
import 'package:chat_app_firebase/feutures/chat/presentation/bloc/send_message_bloc/send_message_bloc.dart'
    as _i8;
import 'package:chat_app_firebase/firebase_module.dart' as _i18;
import 'package:cloud_firestore/cloud_firestore.dart' as _i4;
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:firebase_storage/firebase_storage.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final firebaseModule = _$FirebaseModule();
    gh.factory<_i3.FirebaseAuth>(() => firebaseModule.firebaseAuth);
    gh.factory<_i4.FirebaseFirestore>(() => firebaseModule.firebaseFirestore);
    gh.factory<_i5.FirebaseStorage>(() => firebaseModule.firebaseStorage);
    gh.lazySingleton<_i6.IChatRepository>(() => _i7.FirebaseChatRepository(
          gh<_i3.FirebaseAuth>(),
          gh<_i4.FirebaseFirestore>(),
          gh<_i5.FirebaseStorage>(),
        ));
    gh.factory<_i8.SendMessageBloc>(
        () => _i8.SendMessageBloc(gh<_i6.IChatRepository>()));
    gh.factory<_i9.CreateChatRoomBloc>(
        () => _i9.CreateChatRoomBloc(gh<_i6.IChatRepository>()));
    gh.factory<_i10.SeenMessageBloc>(
        () => _i10.SeenMessageBloc(gh<_i6.IChatRepository>()));
    gh.factory<_i11.GetMessagesBloc>(
        () => _i11.GetMessagesBloc(gh<_i6.IChatRepository>()));
    gh.factory<_i12.GetAllChatsBloc>(
        () => _i12.GetAllChatsBloc(gh<_i6.IChatRepository>()));
    gh.lazySingleton<_i13.IAuthRepository>(() => _i14.FirebaseAuthRepository(
          gh<_i3.FirebaseAuth>(),
          gh<_i4.FirebaseFirestore>(),
        ));
    gh.factory<_i15.GetAllUsersBloc>(
        () => _i15.GetAllUsersBloc(gh<_i13.IAuthRepository>()));
    gh.factory<_i16.GetUserBloc>(
        () => _i16.GetUserBloc(gh<_i13.IAuthRepository>()));
    gh.factory<_i17.SignInBloc>(
        () => _i17.SignInBloc(gh<_i13.IAuthRepository>()));
    return this;
  }
}

class _$FirebaseModule extends _i18.FirebaseModule {}
