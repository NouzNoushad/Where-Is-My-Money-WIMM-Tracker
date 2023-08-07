import 'package:bloc/bloc.dart';
import 'package:expense_tracker/expense_analysis/screens/expense_analysis.dart';
import 'package:expense_tracker/expense_goal/screens/expense_goal.dart';
import 'package:flutter/material.dart';

import '../../expense_home/screens/expense_home.dart';

part 'bottom_nav_state.dart';

class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit() : super(BottomNavInitial());

  int currentIndex = 0;
  changePageIndex(value) {
    currentIndex = value;
    emit(ChangePageState());
  }

  switchPage(int index) {
    Widget selectedPage = switch (index) {
      0 => const ExpenseHome(),
      1 => const ExpenseAnalysis(),
      _ => const ExpenseGoal(),
    };
    return selectedPage;
  }
}
