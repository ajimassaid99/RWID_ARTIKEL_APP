import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final supabase = Supabase.instance.client;
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<SingInWithGoogel>((event, emit) {
      try {
        emit(SinginLoading());
        supabase.auth.signInWithIdToken(
          provider: OAuthProvider.google,
          idToken: event.idToken,
          accessToken: event.accessToken,
        );
        emit(SinginSuccess());
      } catch (e) {
        emit(SinginFailed());
      }
    });
    on<SignIn>((event, emit) async {
      try {
        emit(SinginLoading());
        await supabase.auth.signInWithPassword(
          email: event.email,
          password: event.password,
        );
        emit(SinginSuccess());
      } catch (e) {
        emit(SinginFailed());
      }
    });
  }
}
