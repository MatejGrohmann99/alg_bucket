import 'package:alg_bucket/src/navigation/presentation/navigation_page.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'navigation/presentation/bloc/navigation_bloc.dart';
import 'auth/presentation/bloc/auth_bloc.dart';

class WebApp extends StatelessWidget {
  const WebApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigationBloc>(
          create: (context) => NavigationBloc(),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc()
            ..add(
              const AuthEventSilentSignInAttemptRequest(),
            ),
        )
      ],
      child: const FluentApp(
        themeMode: ThemeMode.dark,
        title: 'Alg bucket',
        home: NavigationPage(),
      ),
    );
  }
}
