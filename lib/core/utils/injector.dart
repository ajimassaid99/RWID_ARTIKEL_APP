import 'package:artikel_aplication/feature/auth/bloc/bloc/authentication_bloc.dart';
import 'package:artikel_aplication/feature/home/bloc/tag_bloc.dart';
import 'package:artikel_aplication/feature/register/bloc/register_bloc.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

void init() {
  locator.registerFactory(() => AuthenticationBloc());
  locator.registerFactory(() => TagBloc());
  locator.registerFactory(() => RegisterBloc());
}
