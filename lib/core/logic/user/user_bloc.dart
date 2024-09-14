import 'dart:async';

import 'package:alg_bucket/core/service/firebase_auth_service.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserStateNew()) {
    on<UserEvent>(_eventHandler, transformer: sequential());
  }

  FutureOr<void> _eventHandler(UserEvent event, Emitter<UserState> emit) async {
    switch (event) {
      case UserEventSilentSignInAttemptRequest():
        emit(const UserStateProcessing());

        final credentialsResult = await FirebaseAuthService.instance.signSilently();

        credentialsResult.fold(
          (error) {
            emit(
              const UserStateNew(),
            );
          },
          (data) {
            emit(
              UserStateLoggedIn(
                userCredential: data.userCredential,
                googleSignInAccount: data.googleSignInAccount,
              ),
            );
          },
        );
      case UserEventSignWithGoogleRequest():
        emit(const UserStateProcessing());

        final credentialsResult = await FirebaseAuthService.instance.signInWithGoogle();

        credentialsResult.fold(
          (error) {
            emit(UserStateFailedLogIn(
              stackTrace: error.stackTrace,
              error: error.error,
            ));
          },
          (data) {
            emit(
              UserStateLoggedIn(
                userCredential: data.userCredential,
                googleSignInAccount: data.googleSignInAccount,
              ),
            );
          },
        );
      case UserEventLogOut():
        emit(const UserStateProcessing());
        final logoutResult = await FirebaseAuthService.instance.logOut();
        logoutResult.fold(
          (error) {
            emit(
              UserStateFailedLogOut(
                stackTrace: error.stackTrace,
                error: error.error,
              ),
            );
          },
          (_) {
            emit(const UserStateNew());
          },
        );
    }
  }
}
