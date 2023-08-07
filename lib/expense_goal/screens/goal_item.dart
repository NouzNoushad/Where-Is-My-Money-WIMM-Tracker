import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/expense_goal/cubit/expense_goal_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/colors.dart';
import '../../widgets/delete_dialog.dart';

class ExpenseGoalItem extends StatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> goal;
  final int index;
  const ExpenseGoalItem({super.key, required this.goal, required this.index});

  @override
  State<ExpenseGoalItem> createState() => _ExpenseGoalItemState();
}

class _ExpenseGoalItemState extends State<ExpenseGoalItem> {
  late ExpenseGoalCubit expenseGoalCubit;

  @override
  void initState() {
    expenseGoalCubit = BlocProvider.of<ExpenseGoalCubit>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4, right: 4),
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 248, 253, 245),
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.18,
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(10.0),
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IntrinsicHeight(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Image.asset(
                              'assets/${widget.goal['image']}',
                              height: 60,
                              width: 60,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    '${widget.goal['category']}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: CustomColors.background4,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  expenseGoalCubit
                                      .checkAchievement(widget.goal)
                                      .toLowerCase(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.pink,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Builder(builder: (context) {
                                  print(
                                      '////////////average; ${widget.goal['average']}');
                                  return LinearProgressIndicator(
                                    value: widget.goal['average'] / 100,
                                    backgroundColor: CustomColors.background2,
                                    color: CustomColors.background4,
                                    minHeight: 12,
                                  );
                                }),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Savings: ₹${widget.goal['savings']}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: CustomColors.background4,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          'Goal: ₹${double.parse(widget.goal['amount'])}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: CustomColors.background4,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                onPressed: () {
                  showDeleteDialog(context, () {
                    expenseGoalCubit.removeGoal(widget.goal['uid']);
                    Navigator.pop(context);
                  });
                },
                icon: const Icon(Icons.close),
                iconSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
