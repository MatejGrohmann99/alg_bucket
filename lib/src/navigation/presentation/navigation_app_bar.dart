import 'package:alg_bucket/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/domain/auth_status.dart';

class WebNavigationAppBar extends NavigationAppBar {
  WebNavigationAppBar()
      : super(
          title: const Text(
            'Alg bucket',
          ),
          automaticallyImplyLeading: false,
          actions: const WebNavigationAppBarActions(),
        );
}

class WebNavigationAppBarActions extends StatelessWidget {
  const WebNavigationAppBarActions({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            final isUserProcessing = state is AuthStateProcessing;

            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (state.status != AuthStatus.authenticated)
                  FilledButton(
                    onPressed: (isUserProcessing)
                        ? null
                        : () {
                            context.read<AuthBloc>().add(
                                  const AuthEventSignWithGoogleRequest(),
                                );
                          },
                    child: const Text('Login with google'),
                  )
                else
                  FilledButton(
                    onPressed: (isUserProcessing)
                        ? null
                        : () {
                            context.read<AuthBloc>().add(
                                  const AuthEventLogOut(),
                                );
                          },
                    child: const Text('Log out'),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
