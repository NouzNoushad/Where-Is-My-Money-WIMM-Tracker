import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/core/constants.dart';
import 'package:expense_tracker/expense_home/service/expense_home_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

part 'expense_home_state.dart';

class ExpenseHomeCubit extends Cubit<ExpenseHomeState> {
  final ExpenseHomeService expenseHomeService;
  ExpenseHomeCubit({required this.expenseHomeService})
      : super(ExpenseHomeInitial());

  late DateTime today;
  late String date;

  TextEditingController amountController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  String selectedCategory = expenseCategory.first;
  ExpenseType expenseType = ExpenseType.expense;
  List<String> categories = expenseCategory;
  double totalExpense = 0.0;
  double totalIncome = 0.0;
  double totalAmount = 0.0;
  bool showDeleteButton = false;
  String uid = '';

  initDate() {
    today = DateTime.now();
    print('//////////////// day $today');
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
    print('////////// today $today');
    formatDate();
    emit(FetchDateState());
  }

  calculateExpense(List<QueryDocumentSnapshot<Map<String, dynamic>>> expenses) {
    totalExpense = expenses
        .where((expense) => expense['expense_type'].contains('Expense'))
        .fold(
            0,
            (previousValue, element) =>
                previousValue + int.parse(element['amount']));
    totalIncome = expenses
        .where((expense) => expense['expense_type'].contains('Income'))
        .fold(
            0,
            (previousValue, element) =>
                previousValue + int.parse(element['amount']));
    totalAmount = totalIncome - totalExpense;
    print('///////////////// Expense $totalExpense');
    print('///////////////// Income $totalIncome');
    print('///////////////// Total $totalAmount');
  }

  onTapExpenseButtonBar() {
    expenseType = ExpenseType.expense;
    selectedCategory = expenseCategory.first;
    categories = expenseCategory;
    emit(ChangeExpenseType());
  }

  onTapIncomeButtonBar() {
    expenseType = ExpenseType.income;
    selectedCategory = incomeCategory.first;
    categories = incomeCategory;
    emit(ChangeExpenseType());
  }

  onChangedCategory(value) {
    selectedCategory = value;
    emit(ChangeCategory());
  }

  amountValidator(String value) {
    if (value.isEmpty) {
      return 'Amount field is required';
    }
    if (value == '0') {
      return 'Amount should not be zero';
    }
    if (!RegExp(r'(^[1-9][0-9]*(\.\d{1,2})?$)').hasMatch(value)) {
      return 'Invalid Amount';
    }
  }

  saveRecord() async {
    String selectedDate = date;
    String category = selectedCategory;
    String expenseTypeString =
        expenseType == ExpenseType.expense ? 'Expense' : 'Income';
    String amount = amountController.text;
    String notes = notesController.text;
    await expenseHomeService.saveRecord(expenseTypeString, category, notes,
        amount, selectedDate, DateTime.now());
    // clear record
    expenseType = ExpenseType.expense;
    selectedCategory = expenseCategory.first;
    categories = expenseCategory;
    amountController.text = '';
    notesController.text = '';
  }

  popupDeleteButton(expenseUid) {
    showDeleteButton = true;
    uid = expenseUid;
    print('///////////// delete button, $showDeleteButton');
    emit(DeleteButtonState());
  }

  disableDeleteButton() {
    showDeleteButton = false;
    print('///////////// delete button, $showDeleteButton');
    emit(DeleteButtonState());
  }

  deleteRecord() async {
    await expenseHomeService.deleteRecord(uid);
    showDeleteButton = false;
    emit(DeleteButtonState());
  }
}
