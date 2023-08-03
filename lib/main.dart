import 'package:expense_tracker/expense_bottom_nav/cubit/bottom_nav_cubit.dart';
import 'package:expense_tracker/expense_bottom_nav/screens/expense_bottom_nav.dart';
import 'package:expense_tracker/expense_home/cubit/expense_home_cubit.dart';
import 'package:expense_tracker/expense_home/service/expense_home_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => BottomNavCubit(),
          ),
          BlocProvider(
            create: (context) => ExpenseHomeCubit(expenseHomeService: ExpenseHomeService()),
          ),
        ],
        child: const ExpenseBottomNavBar(),
      ),
    );
  }
}
