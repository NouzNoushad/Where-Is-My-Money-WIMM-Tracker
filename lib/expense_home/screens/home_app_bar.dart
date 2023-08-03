import 'package:flutter/material.dart';

import '../../core/colors.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 2,
      toolbarHeight: 50,
      pinned: true,
      backgroundColor: CustomColors.background1,
      title: const Text(
        'WIMM Tracker',
        style: TextStyle(
          color: CustomColors.background4,
        ),
      ),
      bottom: PreferredSize(
          preferredSize: const Size(10, 40),
          child: Container(
              // color: Colors.yellow,
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  expenseDetails('Expense', 50),
                  expenseDetails('Income', 50),
                  expenseDetails('Total', 50),
                ],
              ))),
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
            '\$$amount',
            style: const TextStyle(
                color: CustomColors.background4,
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
        ],
      ));
}
