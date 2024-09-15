import 'package:alg_bucket/src/navigation/presentation/bloc/navigation_bloc.dart';
import 'package:alg_bucket/src/navigation/presentation/navigation_progress_overlay.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class NavigationListener extends BlocListener<NavigationBloc, NavigationState> {
  NavigationListener({
    super.child,
    super.key,
  }) : super(
          listener: (context, state) {
            switch (state) {
              case NavigationStateLoading():
                NavigationProgressOverlay.show(context);
              case NavigationStateIdle():
              case NavigationStateLoaded():
              NavigationProgressOverlay.hide();
            }
          },
        );
}
