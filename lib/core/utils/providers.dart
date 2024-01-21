import 'package:artikel_aplication/core/utils/injector.dart' as di;
import 'package:artikel_aplication/feature/artikel/bloc/artikel_bloc.dart';
import 'package:artikel_aplication/feature/auth/bloc/bloc/authentication_bloc.dart';
import 'package:artikel_aplication/feature/home/bloc/tag_bloc.dart';
import 'package:artikel_aplication/feature/register/bloc/register_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Providers {
  static final List<BlocProvider> init = [
    BlocProvider<AuthenticationBloc>(
        create: (context) => di.locator<AuthenticationBloc>()),
    BlocProvider<TagBloc>(create: (context) => di.locator<TagBloc>()),
    BlocProvider<RegisterBloc>(create: (context) => di.locator<RegisterBloc>()),
    BlocProvider<ArtikelBloc>(create: (context) => di.locator<ArtikelBloc>()),
  ];
}
