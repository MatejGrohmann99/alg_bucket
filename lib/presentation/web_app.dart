import 'package:alg_bucket/presentation/fluent_ui/web_page.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/logic/navigation/navigation_bloc.dart';
import '../core/logic/user/user_bloc.dart';

class WebApp extends StatefulWidget {
  const WebApp({super.key});

  @override
  State<WebApp> createState() => _WebAppState();
}

class _WebAppState extends State<WebApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigationBloc>(
          create: (context) => NavigationBloc(),
        ),
        BlocProvider<UserBloc>(
          create: (context) => UserBloc()..add(const UserEventSilentSignInAttemptRequest()),
        )
      ],
      child: const FluentApp(
        themeMode: ThemeMode.dark,
        title: 'Alg bucket',
        home: WebPage(),
      ),
    );
  }
}
