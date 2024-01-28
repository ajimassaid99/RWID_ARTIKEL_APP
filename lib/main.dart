import 'package:artikel_aplication/core/utils/providers.dart';
import 'package:artikel_aplication/feature/auth/view/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:artikel_aplication/core/utils/injector.dart' as di;

void main() async {
  await Supabase.initialize(
    url: 'https://zyjhweeksojjyuiywhmm.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp5amh3ZWVrc29qanl1aXl3aG1tIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDM1OTgxMTQsImV4cCI6MjAxOTE3NDExNH0.8OXBwdPguBvzpawig0VjS2w9JHYP8T7KLvK3Q6KlfKw',
  );
  di.init();
    WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: Providers.init,
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const Scaffold(
            body: Center(child: AuthPage()),
          ),
        ));
  }
}
