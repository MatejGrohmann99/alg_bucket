import 'package:alg_bucket/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/domain/auth_status.dart';

class WebNavigationPane extends NavigationPane {
  WebNavigationPane({
    required super.selected,
    required super.items,
    required super.onChanged,
  }) : super(
          header: const WebNavigationPaneHeader(),
        );
}

class WebNavigationPaneHeader extends StatelessWidget {
  const WebNavigationPaneHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state.status == AuthStatus.authenticated) {
        return const Text('User is logged in');
      }
      return const Text('User is not logged in');
    });
  }
}
