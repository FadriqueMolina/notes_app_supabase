import 'package:flutter/material.dart';
import 'package:notes_app_supabase/screens/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://farsqclyyuymsielqfrk.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZhcnNxY2x5eXV5bXNpZWxxZnJrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDMyMjU1ODgsImV4cCI6MjA1ODgwMTU4OH0.J1-VdFpK8kksKn6DtPwbSKa88CMVFXxZDOtz51P_EB0",
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}
