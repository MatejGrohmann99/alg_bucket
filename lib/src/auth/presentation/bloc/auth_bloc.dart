import 'dart:async';

import 'package:alg_bucket/src/auth/domain/auth_status.dart';
import 'package:alg_bucket/src/auth/domain/user_data.dart';
import 'package:alg_bucket/src/shared/domain/error_response.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/auth_api_interface.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthStateNew()) {
    on<AuthEvent>(_eventHandler, transformer: sequential());
  }

  FutureOr<void> _eventHandler(AuthEvent event, Emitter<AuthState> emit) async {
    switch (event) {
      case AuthEventSilentSignInAttemptRequest():
        emit(const AuthStateProcessing());

        final credentialsResult = await AuthApiInterface.instance.signSilently();

        credentialsResult.fold(
          (error) {
            emit(
              const AuthStateNew(),
            );
          },
          (data) {
            emit(
              AuthStateLoggedIn(
                userData: data,
              ),
            );
          },
        );
      case AuthEventSignWithGoogleRequest():
        emit(const AuthStateProcessing());

        final credentialsResult = await AuthApiInterface.instance.signInWithGoogle();

        credentialsResult.fold(
          (error) {
            emit(AuthStateFailedLogIn(
              error: error,
            ));
          },
          (data) {
            emit(
              AuthStateLoggedIn(
                userData: data,
              ),
            );
          },
        );
      case AuthEventLogOut():
        emit(const AuthStateProcessing());
        final logoutResult = await AuthApiInterface.instance.logOut();
        logoutResult.fold(
          (error) {
            emit(
              AuthStateFailedLogOut(
                error: error,
              ),
            );
          },
          (_) {
            emit(const AuthStateNew());
          },
        );
    }
  }
}
