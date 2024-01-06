import 'package:artikel_aplication/feature/auth/bloc/bloc/authentication_bloc.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

void init() {
  locator.registerFactory(() => AuthenticationBloc());
}
