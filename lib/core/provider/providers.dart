import 'package:chat_app_firebase/core/di/injector.dart';
import 'package:chat_app_firebase/feutures/auth/presentation/bloc/bloc.dart';
import 'package:chat_app_firebase/feutures/chat/presentation/bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Providers extends StatelessWidget {
  const Providers({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CreateChatRoomBloc>(
          create: (context) => getIt<CreateChatRoomBloc>(),
        ),
        BlocProvider<SendMessageBloc>(
          create: (context) => getIt<SendMessageBloc>(),
        ),
        BlocProvider<SeenMessageBloc>(
          create: (context) => getIt<SeenMessageBloc>(),
        ),
        BlocProvider<GetMessagesBloc>(
          create: (context) => getIt<GetMessagesBloc>(),
        ),
        BlocProvider<GetAllChatsBloc>(
          create: (context) => getIt<GetAllChatsBloc>(),
        ),
        BlocProvider<GetAllUsersBloc>(
          create: (context) => getIt<GetAllUsersBloc>(),
        ),
        BlocProvider<GetUserBloc>(
          create: (context) => getIt<GetUserBloc>(),
        ),
        BlocProvider<SignInBloc>(
          create: (context) => getIt<SignInBloc>(),
        ),
      ],
      child: child,
    );
  }
}
