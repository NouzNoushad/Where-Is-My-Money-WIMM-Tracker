import 'package:bloc/bloc.dart';
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
      1 => const Center(child: Text('Analysis')),
      _ => const Center(child: Text('Goals')),
    };
    return selectedPage;
  }
}
