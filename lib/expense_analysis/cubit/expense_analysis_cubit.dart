import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'expense_analysis_state.dart';

class ExpenseAnalysisCubit extends Cubit<ExpenseAnalysisState> {
  ExpenseAnalysisCubit() : super(ExpenseAnalysisInitial());
  Map<String, double> groupExpense = {};
  Map<String, double> groupIncome = {};
  double expenseTotal = 0.0;
  double incomeTotal = 0.0;

  groupeExpenseTypeExpense(expenses) {
    groupExpense = {};
    var expenseList = expenses
        .where((element) => element['expense_type'] == 'Expense')
        .toList();
    for (var expense in expenseList) {
      if (groupExpense.containsKey(expense['category'])) {
        groupExpense[expense['category']] = groupExpense[expense['category']]! +
            double.parse(expense['amount']);
      } else {
        groupExpense[expense['category']] = double.parse(expense['amount']);
      }
    }
    print('///////////// groupexpense : $groupExpense');
  }

  groupeExpenseTypeIncome(expenses) {
    groupIncome = {};
    var incomeList = expenses
        .where((element) => element['expense_type'] == 'Income')
        .toList();
    for (var income in incomeList) {
      if (groupIncome.containsKey(income['category'])) {
        groupIncome[income['category']] =
            groupIncome[income['category']]! + double.parse(income['amount']);
      } else {
        groupIncome[income['category']] = double.parse(income['amount']);
      }
    }
    print('///////////// groupincome : $groupIncome');
  }

  groupByCategory(List<QueryDocumentSnapshot<Map<String, dynamic>>> expenses) {
    groupeExpenseTypeExpense(expenses);
    groupeExpenseTypeIncome(expenses);
    findTotal();
    emit(ExpensePIChart());
  }

  findTotal() {
    expenseTotal = groupExpense.values
        .fold(0.0, (previousValue, element) => previousValue + element);
    incomeTotal = groupIncome.values
        .fold(0.0, (previousValue, element) => previousValue + element);
  }

  double findAverageValue(double value, double total) {
    double expenseAverage = value * 100 / total;
    print('///////////////// Expense Average: $expenseAverage');
    return double.parse(expenseAverage.toStringAsFixed(2));
  }
}
