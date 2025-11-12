import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:taskify/pages/homePage.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Taskify | To Do App',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xff82add8),
        useMaterial3: false,
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xffb7b8bd)),
      ),
      home: Homepage(),
    );
  }
}
