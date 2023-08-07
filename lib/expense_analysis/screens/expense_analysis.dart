import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/expense_analysis/screens/expense_pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/colors.dart';
import '../../core/constants.dart';
import '../../expense_home/cubit/expense_home_cubit.dart';
import '../../expense_home/screens/home_app_bar.dart';
import '../cubit/expense_analysis_cubit.dart';

class ExpenseAnalysis extends StatefulWidget {
  const ExpenseAnalysis({super.key});

  @override
  State<ExpenseAnalysis> createState() => _ExpenseAnalysisState();
}

class _ExpenseAnalysisState extends State<ExpenseAnalysis> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late ExpenseHomeCubit expenseHomeCubit;
  late ExpenseAnalysisCubit expenseAnalysisCubit;
  @override
  void initState() {
    expenseHomeCubit = BlocProvider.of<ExpenseHomeCubit>(context);
    expenseAnalysisCubit = BlocProvider.of<ExpenseAnalysisCubit>(context);
    expenseHomeCubit.initDate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const HomeAppBar(pageType: PageType.analysis,),
          SliverFillRemaining(
            child: Container(
              color: CustomColors.background1,
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  physics: const BouncingScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  children: [
                    BlocBuilder<ExpenseHomeCubit, ExpenseHomeState>(
                      builder: (context, state) {
                        return StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection(expenseDB)
                                .where('date', isEqualTo: expenseHomeCubit.date)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data!.docs.isNotEmpty) {
                                  print(
                                      '///////////////////// snapshot, ${snapshot.data!.docs[0]['date']} ${expenseHomeCubit.date}');
                                  expenseHomeCubit
                                      .calculateExpense(snapshot.data!.docs);
                                  expenseAnalysisCubit
                                      .groupByCategory(snapshot.data!.docs);
                                  return Column(
                                    children: [
                                      Container(
                                          // color: Colors.yellow,
                                          margin:
                                              const EdgeInsets.only(bottom: 10),
                                          child: Row(
                                            children: [
                                              expenseDetails(
                                                  'Expense',
                                                  expenseHomeCubit
                                                      .totalExpense),
                                              expenseDetails('Income',
                                                  expenseHomeCubit.totalIncome),
                                              expenseDetails('Total',
                                                  expenseHomeCubit.totalAmount),
                                            ],
                                          )),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.35,
                                          // color: Colors.yellow,
                                          child: ExpensePieChart(
                                            expenseSnapshot:
                                                snapshot.data!.docs,
                                            groupRecord: expenseAnalysisCubit
                                                .groupExpense,
                                            groupTotal: expenseAnalysisCubit
                                                .expenseTotal,
                                            colors: expenseColors,
                                          )),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.35,
                                          // color: Colors.yellow,
                                          child: ExpensePieChart(
                                            expenseSnapshot:
                                                snapshot.data!.docs,
                                            groupRecord: expenseAnalysisCubit
                                                .groupIncome,
                                            groupTotal: expenseAnalysisCubit
                                                .incomeTotal,
                                            colors: incomeColors,
                                          )),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                    ],
                                  );
                                }
                                return const Center(
                                  child: Text('No Data'),
                                );
                              }
                              return const Center(
                                child: Text('No Data'),
                              );
                            });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget expenseDetails(title, amount) => Expanded(
          child: Column(
        children: [
          Text(
            title.toUpperCase(),
            style: const TextStyle(
                color: CustomColors.background4,
                fontSize: 13,
                fontWeight: FontWeight.w500),
          ),
          Text(
            '₹$amount',
            style: const TextStyle(
                color: CustomColors.background4,
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
        ],
      ));
}
