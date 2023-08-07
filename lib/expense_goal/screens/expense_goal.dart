import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/core/constants.dart';
import 'package:expense_tracker/expense_goal/screens/goal_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/colors.dart';
import '../../expense_home/cubit/expense_home_cubit.dart';
import '../../expense_home/screens/expense_bottom_sheet.dart';
import '../../expense_home/screens/home_app_bar.dart';
import '../cubit/expense_goal_cubit.dart';

class ExpenseGoal extends StatefulWidget {
  const ExpenseGoal({super.key});

  @override
  State<ExpenseGoal> createState() => _ExpenseGoalState();
}

class _ExpenseGoalState extends State<ExpenseGoal> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late ExpenseHomeCubit expenseHomeCubit;
  late ExpenseGoalCubit expenseGoalCubit;

  @override
  void initState() {
    expenseHomeCubit = BlocProvider.of<ExpenseHomeCubit>(context);
    expenseGoalCubit = BlocProvider.of<ExpenseGoalCubit>(context);
    expenseHomeCubit.initDate();
    super.initState();
  }

  @override
  void dispose() {
    expenseHomeCubit.amountController.text = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showExpenseBottomSheet(
              context, expenseHomeCubit, formKey, PageType.goals);
        },
        backgroundColor: CustomColors.background4,
        child: const Icon(
          Icons.add,
          color: CustomColors.background1,
        ),
      ),
      body: CustomScrollView(
        slivers: [
          const HomeAppBar(pageType: PageType.goals,),
          SliverFillRemaining(
            child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection(goalsDB).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Material(
                      color: CustomColors.background1,
                      child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: ListView(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            children: [
                              ...List.generate(snapshot.data!.docs.length,
                                  (index) {
                                QueryDocumentSnapshot<Map<String, dynamic>>
                                    goal = snapshot.data!.docs[index];
                                expenseGoalCubit.findGoalsAverage(goal);
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: BlocBuilder<ExpenseGoalCubit,
                                          ExpenseGoalState>(
                                      builder: (context, state) {
                                    return ExpenseGoalItem(
                                      goal: goal,
                                      index: index,
                                    );
                                  }),
                                );
                              })
                            ],
                          )),
                    );
                  }
                  return const Material(
                    color: CustomColors.background1,
                    child: Center(
                      child: Text('No Data'),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
