part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class SingInWithGoogel extends AuthenticationEvent {
  final String idToken;
  final String accessToken;

  const SingInWithGoogel({required this.idToken, required this.accessToken});

  @override
  List<Object> get props => [idToken, accessToken];
}
