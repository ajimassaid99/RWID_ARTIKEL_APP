import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final supabase = Supabase.instance.client;
  RegisterBloc() : super(RegisterInitial()) {
   on<SingUp>((event, emit) async {
      try {
        emit(RegisterLoading());
        await supabase.auth.signUp(
          email: event.email,
          password: event.password,
          data: {'name': event.name, "no_hp": event.phone},
        );
        emit(RegisterSuccess());
      } catch (e) {
        emit(RegisterError());
      }
    });
  }
}
