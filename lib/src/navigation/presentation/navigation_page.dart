import 'package:alg_bucket/src/auth/presentation/auth_listener.dart';
import 'package:alg_bucket/src/navigation/presentation/navigation_listener.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/navigation_destination.dart';
import 'bloc/navigation_bloc.dart';
import '../../auth/presentation/bloc/auth_bloc.dart';
import 'navigation_app_bar.dart';
import 'navigation_mapper.dart';
import 'navigation_pane.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        AuthListener(
          onUserStateChanged: (context, state) {
            if (state is AuthStateLoggedIn) {
              context.read<NavigationBloc>().add(
                    NavigationEventSetDestinations(
                      NavigationDestinationEnum.logInUserNavigationDestinationItems,
                    ),
                  );
            } else {
              context.read<NavigationBloc>().add(
                    NavigationEventSetDestinations(
                      NavigationDestinationEnum.newUserNavigationDestinationItems,
                    ),
                  );
            }
          },
        ),
        NavigationListener(),
      ],
      child: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          return NavigationView(
            clipBehavior: Clip.none,
            transitionBuilder: (child, anim) => child,
            appBar: WebNavigationAppBar(),
            pane: WebNavigationPane(
              selected: state.destinationIndex,
              items: NavigationMapper.getPaneItems(state.destinations),
              onChanged: (itemIndex) {
                if (state is NavigationStateLoading) return;

                final destination = state.destinations[itemIndex];
                context.read<NavigationBloc>().add(
                      NavigationEventMenuTransition(destination),
                    );
              },
            ),
          );
        },
      ),
    );
  }
}
