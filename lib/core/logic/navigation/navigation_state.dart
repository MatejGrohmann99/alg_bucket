part of 'navigation_bloc.dart';

sealed class NavigationState extends Equatable {
  const NavigationState({this.destination});

  final NavigationDestinationEnum? destination;

  int get index => destination?.destinationIndex ?? 0;

  @override
  List<Object?> get props => [destination];
}

class NavigationStateIdle extends NavigationState {
  const NavigationStateIdle();
}

class NavigationStateLoading extends NavigationState {
  const NavigationStateLoading({required super.destination});
}

class NavigationStateLoaded extends NavigationState {
  const NavigationStateLoaded({required super.destination});
}
