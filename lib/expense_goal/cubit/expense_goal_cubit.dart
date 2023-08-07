import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/expense_goal/service/expense_goal_service.dart';
import 'package:expense_tracker/model/goals_model.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../core/constants.dart';

part 'expense_goal_state.dart';

class ExpenseGoalCubit extends Cubit<ExpenseGoalState> {
  final ExpenseGoalService expenseGoalService;
  ExpenseGoalCubit({required this.expenseGoalService})
      : super(ExpenseGoalInitial());

  String? selectedCategory = expenseCategory.first['name'];
  List<Map<String, String>> categories = expenseCategory;
  // List<double> savingsAmount = [];
  // List<double> goalAverage = [];

  onChangedGoalCategory(value) {
    selectedCategory = value;
    emit(ChangeGoalCategory());
  }

  setExpenseGoals(amount, notes) async {
    String? fetchImage = expenseCategory
        .where((element) => element['name'] == selectedCategory)
        .map((e) => e['image'])
        .toList()[0];
    print('///////////////// goal image $fetchImage');
    String image = fetchImage ?? '';
    String? category = selectedCategory;
    await expenseGoalService.setExpenseGoals(
        category, amount, image, notes, DateTime.now());
    selectedCategory = expenseCategory.first['name'];
    categories = expenseCategory;
  }

  findGoalsAverage(QueryDocumentSnapshot<Map<String, dynamic>> goal) async {
    await expenseGoalService.findGoalsAverage(goal['amount']);
    GoalsModel goalModel = goalsModelFromMap(goal.data());
    await expenseGoalService.saveGoalAverage(goalModel);
    emit(FetchAverageState());
  }

  removeGoal(uid) async {
    await expenseGoalService.removeGoal(uid);
  }

  String checkAchievement(QueryDocumentSnapshot<Map<String, dynamic>> goal) {
    if (goal['average'] == double.parse(goal['amount'])) {
      return 'Goal Achieved';
    } else {
      return 'Keep going..';
    }
  }
}
