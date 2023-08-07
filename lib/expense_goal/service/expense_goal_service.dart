import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/core/constants.dart';
import 'package:expense_tracker/model/goals_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

import '../../core/colors.dart';

class ExpenseGoalService {
  double totalAmount = 0.0;
  double goalAverage = 0.0;
  setExpenseGoals(category, amount, image, notes, createdOn) async {
    GoalsModel goalsModel = GoalsModel(
        uid: const Uuid().v1(),
        category: category,
        notes: notes,
        amount: amount,
        image: image,
        createdOn: createdOn);
    await FirebaseFirestore.instance
        .collection(goalsDB)
        .doc(goalsModel.uid)
        .set(goalsModelToMap(goalsModel))
        .then((value) {
      Fluttertoast.showToast(
          msg: 'Goal added successfully',
          backgroundColor: CustomColors.background1,
          textColor: CustomColors.background4);
      print('////////////////// successful');
    }).catchError((err) {
      Fluttertoast.showToast(
          msg: 'Could not add your goal',
          backgroundColor: CustomColors.background1,
          textColor: CustomColors.background4);
      print('Error occured: $err');
    });
  }

  findGoalsAverage(targetAmount) async {
    QuerySnapshot<Map<String, dynamic>> expenseList =
        await FirebaseFirestore.instance.collection(expenseDB).get();
    var totalExpense = expenseList.docs
        .where((element) => element['expense_type'] == 'Expense')
        .fold(
            0.0,
            (previousValue, element) =>
                previousValue + double.parse(element['amount']));
    var totalIncome = expenseList.docs
        .where((element) => element['expense_type'] == 'Income')
        .fold(
            0.0,
            (previousValue, element) =>
                previousValue + double.parse(element['amount']));
    totalAmount = totalIncome - totalExpense;
    goalAverage = (totalAmount / double.parse(targetAmount));
    print('////// Total expense: $totalExpense');
    print('////// Total income: $totalIncome');
    print('////// Total amount: $totalAmount');
    print('////// Target amount: ${double.parse(targetAmount)}');
    print('////// Goal average: $goalAverage');
  }

  saveGoalAverage(GoalsModel goalModel) async {
    goalModel.savings = totalAmount;
    goalModel.average = goalAverage <= 0 ? 0 : goalAverage * 100;
    await FirebaseFirestore.instance
        .collection(goalsDB)
        .doc(goalModel.uid)
        .set(goalsModelToMap(goalModel));
  }

  removeGoal(uid) async {
    await FirebaseFirestore.instance.collection(goalsDB).doc(uid).delete().then((value) {
      Fluttertoast.showToast(
          msg: 'Goal removed successfully',
          backgroundColor: CustomColors.background1,
          textColor: CustomColors.background4);
      print('////////////////// successful');
    }).catchError((err) {
      Fluttertoast.showToast(
          msg: 'Could not remove your goal',
          backgroundColor: CustomColors.background1,
          textColor: CustomColors.background4);
      print('Error occured: $err');
    });
  }
}
