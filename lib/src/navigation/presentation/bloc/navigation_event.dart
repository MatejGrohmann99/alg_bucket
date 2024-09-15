part of 'navigation_bloc.dart';

sealed class NavigationEvent extends Equatable {
  const NavigationEvent();
}

class NavigationEventSetDestinations extends NavigationEvent {
  const NavigationEventSetDestinations(this.destinations);

  final List<NavigationDestinationEnum> destinations;

  @override
  List<Object?> get props => [destinations];

}

class NavigationEventStartTransition extends NavigationEvent {
  const NavigationEventStartTransition(this.targetDestination);

  final NavigationDestinationEnum targetDestination;

  @override
  List<Object?> get props => [targetDestination];
}

class NavigationEventCompleteTransition extends NavigationEvent {
  const NavigationEventCompleteTransition(this.targetDestination);

  final NavigationDestinationEnum targetDestination;

  @override
  List<Object?> get props => [targetDestination];
}

class NavigationEventMenuTransition extends NavigationEvent {
  const NavigationEventMenuTransition(this.targetDestination);

  final NavigationDestinationEnum targetDestination;

  @override
  List<Object?> get props => [targetDestination];
}
