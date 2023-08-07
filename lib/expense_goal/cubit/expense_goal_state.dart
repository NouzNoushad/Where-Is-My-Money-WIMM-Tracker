part of 'expense_goal_cubit.dart';

@immutable
abstract class ExpenseGoalState {}

class ExpenseGoalInitial extends ExpenseGoalState {}

class ChangeGoalCategory extends ExpenseGoalState{}

class FetchAverageState extends ExpenseGoalState{}