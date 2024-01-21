part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class SinginSuccess extends AuthenticationState {}

class SinginLoading extends AuthenticationState {}

class SinginFailed extends AuthenticationState {}

class SignOutSuccess extends AuthenticationState {}

class SignOutLoading extends AuthenticationState {}

class SignOutFailed extends AuthenticationState {}

class TegUserExist extends AuthenticationState {}

class TegUserNotExist extends AuthenticationState {}
