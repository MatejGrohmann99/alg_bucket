part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => const [];
}

class UserStateNew extends UserState {
  const UserStateNew();
}

class UserStateProcessing extends UserState {
  const UserStateProcessing();
}

sealed class UserStateFailed extends UserState {
  const UserStateFailed({
    required this.error,
    required this.stackTrace,
  });

  final dynamic error;
  final StackTrace stackTrace;

  String get title;

  @override
  List<Object?> get props => [
        error,
        stackTrace,
      ];
}

class UserStateFailedLogIn extends UserStateFailed {
  const UserStateFailedLogIn({required super.error, required super.stackTrace});

  @override
  String get title => 'Log in failed';
}

class UserStateFailedLogOut extends UserStateFailed {
  const UserStateFailedLogOut({required super.error, required super.stackTrace});

  @override
  String get title => 'Log out failed';
}

class UserStateLoggedIn extends UserState {
  const UserStateLoggedIn({
    required this.userCredential,
    required this.googleSignInAccount,
  });

  final UserCredential? userCredential;
  final GoogleSignInAccount? googleSignInAccount;

  @override
  List<Object?> get props => [
        userCredential,
        googleSignInAccount,
      ];
}
