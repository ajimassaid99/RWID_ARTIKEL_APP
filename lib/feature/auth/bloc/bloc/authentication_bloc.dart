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
    on<SingInWithGoogel>((event, emit) async {
      try {
        emit(SinginLoading());
        await supabase.auth.signInWithIdToken(
          provider: OAuthProvider.google,
          idToken: event.idToken,
          accessToken: event.accessToken,
        );
        final currentUser = supabase.auth.currentUser;
        await supabase.from('users').upsert([
          {
            'user_id': currentUser?.id,
            'nama': event.name,
            'email': event.email,
            'url_image': event.urlImage
          }
        ]);

        emit(SinginSuccess());
      } catch (e) {
        print('Error during sign-in: $e');
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
    on<CekUserTag>((event, emit) async {
      try {
        emit(SinginLoading());
        final Session? session = supabase.auth.currentSession;

        List dataMinat = await supabase
            .from('minat_user')
            .select()
            .eq('user_id', session?.user.id ?? '');
        if (dataMinat.isNotEmpty) {
          emit(TegUserExist());
        } else {
          emit(TegUserNotExist());
        }
      } catch (e) {
        emit(TegUserNotExist());
      }
    });

    on<SignOut>((event, emit) async {
  try {
    emit(SignOutLoading());
    
    await supabase.auth.signOut();

    emit(SignOutSuccess());
  } catch (e) {
    print('Error during sign-out: $e');
    emit(SignOutFailed());
  }
});

  }
}
