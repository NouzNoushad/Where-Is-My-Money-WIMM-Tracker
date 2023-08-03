part of 'expense_home_cubit.dart';

@immutable
abstract class ExpenseHomeState {}

class ExpenseHomeInitial extends ExpenseHomeState {}

class FetchDateState extends ExpenseHomeState{}

class ChangeExpenseType extends ExpenseHomeState{}

class ChangeCategory extends ExpenseHomeState{}

class DeleteButtonState extends ExpenseHomeState{}



