import 'package:expense_tracker/expense_bottom_nav/cubit/bottom_nav_cubit.dart';
import 'package:expense_tracker/expense_bottom_nav/screens/expense_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // useMaterial3: true,
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => BottomNavCubit(),
        child: const ExpenseBottomNavBar(),
      ),
    );
  }
}
