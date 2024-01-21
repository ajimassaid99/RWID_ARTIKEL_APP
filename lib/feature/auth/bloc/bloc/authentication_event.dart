part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class SingInWithGoogel extends AuthenticationEvent {
  final String idToken;
  final String accessToken;
  final String name;
  final String email;
  final String urlImage;

  const SingInWithGoogel({required this.idToken, required this.accessToken, required this.name, required this.email, required this.urlImage});

  @override
  List<Object> get props => [idToken, accessToken,name,email,urlImage];
}


 class SignIn extends AuthenticationEvent {
  final String email;
  final String password;

  const SignIn({required this.email, required this.password});

  @override
  List<Object> get props => [email,password];
}

class CekUserTag extends AuthenticationEvent{
 
  const CekUserTag();

 @override
  List<Object> get props => [];

}

class SignOut extends AuthenticationEvent{
 
  const SignOut();

 @override
  List<Object> get props => [];

}