part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  Map<String, Object>? toMap() => null;
}

class UserEventSilentSignInAttemptRequest extends UserEvent {
  const UserEventSilentSignInAttemptRequest();

  @override
  List<Object?> get props => [];
}

class UserEventSignWithGoogleRequest extends UserEvent {
  const UserEventSignWithGoogleRequest();

  @override
  List<Object?> get props => [];
}

class UserEventLogOut extends UserEvent {
  const UserEventLogOut();

  @override
  List<Object?> get props => [];
}
