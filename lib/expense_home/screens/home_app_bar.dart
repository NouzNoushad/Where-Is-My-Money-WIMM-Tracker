import 'package:expense_tracker/expense_analysis/cubit/expense_analysis_cubit.dart';
import 'package:expense_tracker/widgets/delete_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/colors.dart';
import '../../core/constants.dart';
import '../cubit/expense_home_cubit.dart';

class HomeAppBar extends StatelessWidget {
  final PageType pageType;
  const HomeAppBar({super.key, required this.pageType});

  @override
  Widget build(BuildContext context) {
    var expenseHomeCubit = BlocProvider.of<ExpenseHomeCubit>(context);
    var expenseAnalysisCubit = BlocProvider.of<ExpenseAnalysisCubit>(context);
    return BlocBuilder<ExpenseHomeCubit, ExpenseHomeState>(
      builder: (context, state) {
        return SliverAppBar(
          elevation: 2,
          // toolbarHeight: 40,
          pinned: true,
          backgroundColor: CustomColors.background1,
          leading: expenseHomeCubit.showDeleteButton
              ? IconButton(
                  onPressed: () {
                    expenseHomeCubit.disableDeleteButton();
                  },
                  icon: const Icon(Icons.arrow_back),
                  color: CustomColors.background4,
                )
              : null,
          title: const Text(
            'WIMM Tracker',
            style: TextStyle(
              color: CustomColors.background4,
            ),
          ),
          centerTitle: true,
          actions: expenseHomeCubit.showDeleteButton
              ? [
                  IconButton(
                    onPressed: () {
                      showDeleteDialog(context, () {
                        expenseHomeCubit.deleteRecord();
                        Navigator.pop(context);
                      });
                    },
                    icon: const Icon(Icons.delete_rounded),
                    color: CustomColors.background4,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ]
              : [],
          bottom: PreferredSize(
            preferredSize: const Size(10, 30),
            child: BlocBuilder<ExpenseHomeCubit, ExpenseHomeState>(
              builder: (context, state) {
                return Column(
                  children: [
                    Material(
                      color: CustomColors.backgroundLight2,
                      child: Row(
                        children: [
                          Expanded(
                            child: pageType == PageType.goals
                                ? Container(
                                    height: 48,
                                  )
                                : IconButton(
                                    onPressed: () {
                                      expenseHomeCubit
                                          .swipeDate(DateState.previous);
                                      expenseAnalysisCubit.groupExpense = {};
                                    },
                                    icon: const Icon(Icons.arrow_back_ios),
                                    color: CustomColors.background4,
                                  ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: Text(
                                expenseHomeCubit.date,
                                style: const TextStyle(
                                    color: CustomColors.background4,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                          Expanded(
                            child: pageType == PageType.goals
                                ? Container(
                                    height: 48,
                                  )
                                : IconButton(
                                    onPressed: () {
                                      expenseHomeCubit
                                          .swipeDate(DateState.next);
                                      expenseAnalysisCubit.groupExpense = {};
                                    },
                                    icon: const Icon(Icons.arrow_forward_ios),
                                    color: CustomColors.background4,
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
