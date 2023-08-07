import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/colors.dart';
import '../cubit/expense_home_cubit.dart';

class ExpenseListItems extends StatelessWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> expense;
  final int index;
  const ExpenseListItems(
      {super.key, required this.expense, required this.index});

  @override
  Widget build(BuildContext context) {
    var expenseHomeCubit = BlocProvider.of<ExpenseHomeCubit>(context);
    return Column(
      children: [
        InkWell(
          onLongPress: () {
            expenseHomeCubit.popupDeleteButton(expense['uid']);
          },
          child: Container(
              // color: Colors.yellow,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: CustomColors.background1,
                    child: Image.asset('assets/${expense['image']}'),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${expense['category']}',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text('${expense['notes']}')
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    expense['expense_type'] == 'Expense'
                        ? '-${expense['amount']}'
                        : '+${expense['amount']}',
                    style: TextStyle(
                        fontSize: 16,
                        color: expense['expense_type'] == 'Expense'
                            ? Colors.red
                            : Colors.green,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              )),
        ),
        index != 9
            ? const Divider(
                color: CustomColors.background2,
              )
            : Container(),
      ],
    );
  }
}
