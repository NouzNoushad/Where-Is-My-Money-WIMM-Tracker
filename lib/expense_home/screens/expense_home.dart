import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/core/colors.dart';
import 'package:expense_tracker/core/constants.dart';
import 'package:expense_tracker/expense_home/cubit/expense_home_cubit.dart';
import 'package:expense_tracker/expense_home/screens/expense_bottom_sheet.dart';
import 'package:expense_tracker/expense_home/screens/expense_list_items.dart';
import 'package:expense_tracker/expense_home/screens/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseHome extends StatefulWidget {
  const ExpenseHome({super.key});

  @override
  State<ExpenseHome> createState() => _ExpenseHomeState();
}

class _ExpenseHomeState extends State<ExpenseHome> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late ExpenseHomeCubit expenseHomeCubit;
  @override
  void initState() {
    expenseHomeCubit = BlocProvider.of<ExpenseHomeCubit>(context);
    expenseHomeCubit.initDate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showExpenseBottomSheet(context, expenseHomeCubit, formKey);
        },
        backgroundColor: CustomColors.background4,
        child: const Icon(
          Icons.add,
          color: CustomColors.background1,
        ),
      ),
      body: CustomScrollView(
        slivers: [
          const HomeAppBar(),
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
                                      Container(
                                        color: CustomColors.background2,
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 4),
                                        child: Text(
                                          expenseHomeCubit.date,
                                          style: const TextStyle(
                                              color: CustomColors.background4,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      ...List.generate(
                                          snapshot.data!.docs.length, (index) {
                                        var expense =
                                            snapshot.data!.docs[index];
                                        return ExpenseListItems(
                                          expense: expense,
                                          index: index,
                                        );
                                      }).reversed,
                                    ],
                                  );
                                }
                                return const Center(
                                  child: Text('No Data'),
                                );
                              }
                              return Builder(builder: (context) {
                                return const Center(
                                  child: Text('No Data'),
                                );
                              });
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
