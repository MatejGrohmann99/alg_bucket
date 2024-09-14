import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'navigation_event.dart';

part 'navigation_state.dart';

part 'navigation_destination.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const NavigationStateIdle()) {
    on<NavigationEvent>(_eventHandler, transformer: sequential());
  }

  FutureOr<void> _eventHandler(NavigationEvent event, Emitter<NavigationState> emit) async {
    switch (event) {
      case NavigationEventStartTransition():
        emit(NavigationStateLoading(destination: event.targetDestination));
      case NavigationEventCompleteTransition():
        emit(NavigationStateLoaded(destination: event.targetDestination));
      case NavigationEventMenuTransition():
        emit(NavigationStateLoading(destination: event.targetDestination));
        await Future.delayed(const Duration(milliseconds: 300));
        emit(NavigationStateLoaded(destination: event.targetDestination));
    }
  }
}
