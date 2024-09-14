part of 'navigation_bloc.dart';

sealed class NavigationEvent extends Equatable {
  const NavigationEvent();

  Map<String, Object>? toMap();
}

class NavigationEventStartTransition extends NavigationEvent {
  const NavigationEventStartTransition(this.targetDestination);

  final NavigationDestinationEnum targetDestination;

  @override
  List<Object?> get props => [targetDestination];

  @override
  Map<String, Object>? toMap() {
    return {
      'target-destination-name': targetDestination.name,
    };
  }
}

class NavigationEventCompleteTransition extends NavigationEvent {
  const NavigationEventCompleteTransition(this.targetDestination);

  final NavigationDestinationEnum targetDestination;

  @override
  List<Object?> get props => [targetDestination];

  @override
  Map<String, Object>? toMap() {
    return {
      'target-destination-name': targetDestination.name,
    };
  }
}

class NavigationEventMenuTransition extends NavigationEvent {
  const NavigationEventMenuTransition(this.targetDestination);

  final NavigationDestinationEnum targetDestination;

  @override
  List<Object?> get props => [targetDestination];

  @override
  Map<String, Object>? toMap() {
    return {
      'target-destination-name': targetDestination.name,
    };
  }
}
