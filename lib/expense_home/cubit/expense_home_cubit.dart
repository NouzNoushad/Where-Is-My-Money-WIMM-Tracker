import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:expense_tracker/core/constants.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'expense_home_state.dart';

class ExpenseHomeCubit extends Cubit<ExpenseHomeState> {
  ExpenseHomeCubit() : super(ExpenseHomeInitial());

  late DateTime today;
  late String date;

  String selectedCategory = expenseCategory.first;

  initDate() {
    today = DateTime.now();
    formatDate();
  }

  formatDate() {
    date = DateFormat.yMMMd().format(today);
  }

  swipeDate(dateState) {
    DateTime changeDate = dateState == DateState.previous
        ? today.subtract(const Duration(days: 1))
        : today.add(const Duration(days: 1));
    today = changeDate;
    formatDate();
    emit(FetchDateState());
  }

}
