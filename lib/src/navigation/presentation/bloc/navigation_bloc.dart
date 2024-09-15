import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/navigation_destination.dart';

part 'navigation_event.dart';

part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationStateIdle()) {
    on<NavigationEvent>(_eventHandler, transformer: sequential());
  }

  FutureOr<void> _eventHandler(NavigationEvent event, Emitter<NavigationState> emit) async {
    switch (event) {
      case NavigationEventSetDestinations():
        emit(
          NavigationStateLoaded(
            destination: event.destinations.contains(state.destination) ? state.destination : event.destinations.first,
            destinations: event.destinations,
          ),
        );
      case NavigationEventStartTransition():
        emit(
          NavigationStateLoading(
            destination: event.targetDestination,
            destinations: state.destinations,
          ),
        );
      case NavigationEventCompleteTransition():
        emit(
          NavigationStateLoaded(
            destination: event.targetDestination,
            destinations: state.destinations,
          ),
        );
      case NavigationEventMenuTransition():
        emit(
          NavigationStateLoading(
            destination: event.targetDestination,
            destinations: state.destinations,
          ),
        );
        await Future.delayed(const Duration(milliseconds: 300));
        emit(
          NavigationStateLoaded(
            destination: event.targetDestination,
            destinations: state.destinations,
          ),
        );
    }
  }
}
