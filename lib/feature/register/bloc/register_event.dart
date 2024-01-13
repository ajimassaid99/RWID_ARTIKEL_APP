part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}
 class SingUp extends RegisterEvent {
  final String email;
  final String password;
  final String phone;
  final String name;

  const SingUp({required this.password, required this.email, required this.name, required this.phone});

  @override
  List<Object> get props => [password,phone,name,email];
}