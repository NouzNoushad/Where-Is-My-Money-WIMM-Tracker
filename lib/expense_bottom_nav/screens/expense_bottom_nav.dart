import 'package:expense_tracker/expense_bottom_nav/cubit/bottom_nav_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/colors.dart';

class ExpenseBottomNavBar extends StatefulWidget {
  const ExpenseBottomNavBar({super.key});

  @override
  State<ExpenseBottomNavBar> createState() => _ExpenseBottomNavBarState();
}

class _ExpenseBottomNavBarState extends State<ExpenseBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    BottomNavCubit bottomNavCubit = BlocProvider.of<BottomNavCubit>(context);
    return Scaffold(
      bottomNavigationBar: BlocBuilder<BottomNavCubit, BottomNavState>(
        builder: (context, state) {
          return BottomNavigationBar(
              currentIndex: bottomNavCubit.currentIndex,
              onTap: bottomNavCubit.changePageIndex,
              backgroundColor: CustomColors.background1,
              selectedItemColor: CustomColors.background4,
              unselectedItemColor: CustomColors.background3,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.receipt), label: 'Records'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.analytics), label: 'Analysis'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.gamepad), label: 'Goals'),
              ]);
        },
      ),
      body: BlocBuilder<BottomNavCubit, BottomNavState>(
        builder: (context, state) {
          return bottomNavCubit.switchPage(bottomNavCubit.currentIndex);
        },
      ),
    );
  }
}
