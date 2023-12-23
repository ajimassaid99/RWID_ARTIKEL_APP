import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://qbliojdwcvesojyftpmz.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFibGlvamR3Y3Zlc29qeWZ0cG16Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDI0NzQxNjgsImV4cCI6MjAxODA1MDE2OH0.mvcWQkCaD5Uq0ug0YvV9A0eNy04jjvqlWJC8lYKX78k',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(
         child: Text("Welcome")
        ),
      ),
    );
  }
}
