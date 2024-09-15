part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  Map<String, Object>? toMap() => null;
}

class AuthEventSilentSignInAttemptRequest extends AuthEvent {
  const AuthEventSilentSignInAttemptRequest();

  @override
  List<Object?> get props => [];
}

class AuthEventSignWithGoogleRequest extends AuthEvent {
  const AuthEventSignWithGoogleRequest();

  @override
  List<Object?> get props => [];
}

class AuthEventLogOut extends AuthEvent {
  const AuthEventLogOut();

  @override
  List<Object?> get props => [];
}
