part of 'navigation_bloc.dart';

sealed class NavigationState extends Equatable {
  const NavigationState({this.destination, this.destinations = const []});

  final NavigationDestinationEnum? destination;

  final List<NavigationDestinationEnum> destinations;

  int get destinationIndex => destination == null ? 0 : destinations.indexOf(destination!);

  @override
  List<Object?> get props => [destination, destinations];
}

class NavigationStateIdle extends NavigationState {
  NavigationStateIdle()
      : super(
          destinations: NavigationDestinationEnum.newUserNavigationDestinationItems,
        );
}

class NavigationStateLoading extends NavigationState {
  const NavigationStateLoading({required super.destination, required super.destinations});
}

class NavigationStateLoaded extends NavigationState {
  const NavigationStateLoaded({required super.destination, required super.destinations});
}
