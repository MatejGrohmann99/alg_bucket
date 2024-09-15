import 'package:alg_bucket/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/presentation/error_content_dialog.dart';

class AuthListener extends BlocListener<AuthBloc, AuthState> {
  AuthListener({
    void Function(BuildContext context, AuthState state)? onUserStateChanged,
    super.child,
    super.key,
  }) : super(
          listenWhen: (previous, current) {
            return previous.runtimeType != current.runtimeType;
          },
          listener: (context, state) {
            onUserStateChanged?.call(context, state);

            switch (state) {
              case AuthStateFailed():
                ErrorContentDialog.show(
                  title: state.error.message,
                  stackTrace: state.error.stackTrace,
                  error: state.error.error,
                  context: context,
                );
              case _:
            }
          },
        );
}
