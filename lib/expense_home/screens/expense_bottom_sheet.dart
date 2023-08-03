import 'package:animated_button_bar/animated_button_bar.dart';
import 'package:expense_tracker/core/colors.dart';
import 'package:expense_tracker/core/constants.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_text_field.dart';
import '../cubit/expense_home_cubit.dart';

showExpenseBottomSheet(
    BuildContext context, ExpenseHomeCubit expenseHomeCubit) {
  showModalBottomSheet(
      backgroundColor: CustomColors.background1,
      context: context,
      builder: (context) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AnimatedButtonBar(
                  backgroundColor: CustomColors.background3,
                  foregroundColor: CustomColors.background4,
                  radius: 8.0,
                  invertedSelection: true,
                  children: [
                    ButtonBarEntry(
                        onTap: () => print('First item tapped'),
                        child: const Text(
                          'Expense',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        )),
                    ButtonBarEntry(
                        onTap: () => print('Second item tapped'),
                        child: const Text(
                          'Income',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        )),
                  ],
                ),
                Container(
                  width: 180,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  // padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          width: 1.5, color: CustomColors.background4)),
                  child: DropdownButton(
                      hint: const Text('Category'),
                      underline: Container(),
                      icon: const Icon(Icons.arrow_drop_down),
                      isExpanded: false,
                      isDense: true,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      value: expenseHomeCubit.selectedCategory,
                      dropdownColor: CustomColors.background1,
                      borderRadius: BorderRadius.circular(20),
                      items: expenseCategory
                          .map((code) => DropdownMenuItem(
                              value: code,
                              child: Center(
                                child: Text(
                                  code,
                                  style: const TextStyle(
                                      fontSize: 16.5,
                                      fontWeight: FontWeight.w500,
                                      color: CustomColors.background4),
                                ),
                              )))
                          .toList(),
                      onChanged: (value) {}),
                ),
                const ExpenseTextFormField(
                  hintText: 'Amount',
                  icon: Icons.wallet,
                  keyboardType: TextInputType.phone,
                ),
                // const SizedBox(
                //   height: 10,
                // ),
                const ExpenseTextFormField(
                  hintText: 'Note',
                  icon: Icons.edit,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: CustomColors.background4,
                              child: Icon(
                                Icons.close,
                                color: CustomColors.background1,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Cancel',
                              style: TextStyle(
                                  color: CustomColors.background4,
                                  fontSize: 18),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: CustomColors.background4,
                              child: Icon(
                                Icons.done,
                                color: CustomColors.background1,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Save',
                              style: TextStyle(
                                  color: CustomColors.background4,
                                  fontSize: 18),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ));
}
