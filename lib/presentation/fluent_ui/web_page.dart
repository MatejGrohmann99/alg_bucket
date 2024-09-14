import 'package:alg_bucket/presentation/fluent_ui/mappers/icon_mapper.dart';
import 'package:alg_bucket/presentation/fluent_ui/mappers/view_mapper.dart';
import 'package:alg_bucket/presentation/fluent_ui/widgets/error_content_dialog.dart';
import 'package:alg_bucket/presentation/fluent_ui/widgets/progress_bar_overlay.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/logic/navigation/navigation_bloc.dart';
import '../../core/logic/user/user_bloc.dart';

class WebPage extends StatelessWidget {
  const WebPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        switch (state) {
          case UserStateFailed():
            ErrorContentDialog.show(
              title: state.title,
              stackTrace: state.stackTrace,
              error: state.error,
              context: context,
            );

          case _:
        }
      },
      builder: (context, userState) {
        final isUserLoggedIn = userState is UserStateLoggedIn;
        final isUserProcessing = userState is UserStateProcessing;

        final navigationDestinationList = (isUserLoggedIn
            ? NavigationDestinationEnum.logInUserNavigationDestinationItems
            : NavigationDestinationEnum.newUserNavigationDestinationItems);
        final navigationItems = navigationDestinationList.map<NavigationPaneItem>(
          (item) {
            return PaneItem(
              infoBadge: Tooltip(
                message: item.tooltip,
              ),
              title: Text(item.title),
              body: WebViewMapper.view(item),
              icon: Icon(WebIconMapper.icon(item)),
            );
          },
        ).toList();

        return BlocConsumer<NavigationBloc, NavigationState>(
          listener: (context, state) {
            switch (state) {
              case NavigationStateLoading():
                ProgressBarOverlay.show(context);
              case NavigationStateIdle():
              case NavigationStateLoaded():
                ProgressBarOverlay.hide();
            }
          },
          builder: (context, state) {
            return NavigationView(
              clipBehavior: Clip.none,
              transitionBuilder: (child, anim) => child,
              appBar: NavigationAppBar(
                title: const Text(
                  'Alg bucket',
                ),
                automaticallyImplyLeading: false,
                actions: SizedBox(
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        !isUserLoggedIn
                            ? FilledButton(
                                child: const Text('Login with google'),
                                onPressed: () {
                                  if (isUserProcessing) return;
                                  context.read<UserBloc>().add(
                                        const UserEventSignWithGoogleRequest(),
                                      );
                                },
                              )
                            : FilledButton(
                                child: const Text('Log out'),
                                onPressed: () {
                                  if (isUserProcessing) return;
                                  context.read<UserBloc>().add(
                                        const UserEventLogOut(),
                                      );
                                },
                              ),
                      ],
                    ),
                  ),
                ),
              ),
              pane: NavigationPane(
                header: isUserLoggedIn
                    ? Text(
                        userState.googleSignInAccount?.email ?? 'unknown email',
                      )
                    : null,
                selected: state.index,
                items: navigationItems,
                onChanged: (itemIndex) {
                  if (state is NavigationStateLoading) return;

                  final destination = navigationDestinationList[itemIndex];
                  context.read<NavigationBloc>().add(
                        NavigationEventMenuTransition(destination),
                      );
                },
              ),
            );
          },
        );
      },
    );
  }
}
