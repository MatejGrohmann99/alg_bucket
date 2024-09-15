part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  AuthStatus get status;

  @override
  List<Object?> get props => const [];
}

class AuthStateNew extends AuthState {
  const AuthStateNew();

  @override
  AuthStatus get status => AuthStatus.unauthenticated;
}

class AuthStateProcessing extends AuthState {
  const AuthStateProcessing();

  @override
  AuthStatus get status => AuthStatus.unauthenticated;
}

sealed class AuthStateFailed extends AuthState {
  const AuthStateFailed({
    required this.error,
  });

  final ErrorResponse error;

  @override
  List<Object?> get props => [
        error,
      ];
}

class AuthStateFailedLogIn extends AuthStateFailed {
  const AuthStateFailedLogIn({required super.error});

  @override
  AuthStatus get status => AuthStatus.unauthenticated;
}

class AuthStateFailedLogOut extends AuthStateFailed {
  const AuthStateFailedLogOut({required super.error});

  @override
  AuthStatus get status => AuthStatus.authenticated;
}

class AuthStateLoggedIn extends AuthState {
  const AuthStateLoggedIn({
    required this.userData,
  });

  final UserData userData;

  @override
  AuthStatus get status => AuthStatus.authenticated;

  @override
  List<Object?> get props => [
        userData,
      ];
}
