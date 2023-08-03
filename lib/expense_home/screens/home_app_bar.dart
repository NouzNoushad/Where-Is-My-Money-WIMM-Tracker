import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/colors.dart';
import '../../core/constants.dart';
import '../cubit/expense_home_cubit.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    var expenseHomeCubit = BlocProvider.of<ExpenseHomeCubit>(context);
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
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      'Delete this record',
                                      style: TextStyle(
                                        color: CustomColors.background4,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      'Are you sure?',
                                      style: TextStyle(
                                        color: CustomColors.background4,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    CustomColors.background4),
                                            child: const Text(
                                              'No',
                                              style: TextStyle(
                                                color: CustomColors.background1,
                                              ),
                                            )),
                                        ElevatedButton(
                                            onPressed: () {
                                              expenseHomeCubit.deleteRecord();
                                              Navigator.pop(context);
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    CustomColors.background4),
                                            child: const Text(
                                              'Yes',
                                              style: TextStyle(
                                                color: CustomColors.background1,
                                              ),
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ));
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
                    Row(
                      children: [
                        Expanded(
                          child: IconButton(
                            onPressed: () {
                              expenseHomeCubit.swipeDate(DateState.previous);
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
                          child: IconButton(
                            onPressed: () {
                              expenseHomeCubit.swipeDate(DateState.next);
                            },
                            icon: const Icon(Icons.arrow_forward_ios),
                            color: CustomColors.background4,
                          ),
                        ),
                      ],
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
