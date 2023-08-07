import 'package:animated_button_bar/animated_button_bar.dart';
import 'package:expense_tracker/core/colors.dart';
import 'package:expense_tracker/expense_goal/cubit/expense_goal_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants.dart';
import '../../widgets/custom_text_field.dart';
import '../cubit/expense_home_cubit.dart';

showExpenseBottomSheet(BuildContext context, ExpenseHomeCubit expenseHomeCubit,
    formKey, pageType) {
  ExpenseGoalCubit expenseGoalCubit =
      BlocProvider.of<ExpenseGoalCubit>(context);
  showModalBottomSheet(
    backgroundColor: CustomColors.background1,
    context: context,
    isScrollControlled: true,
    builder: (builderContext) => Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(builderContext).viewInsets.bottom),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            pageType == PageType.goals
                ? const SizedBox.shrink()
                : AnimatedButtonBar(
                    backgroundColor: CustomColors.background3,
                    foregroundColor: CustomColors.background4,
                    radius: 8.0,
                    invertedSelection: true,
                    children: [
                      ButtonBarEntry(
                          onTap: expenseHomeCubit.onTapExpenseButtonBar,
                          child: const Text(
                            'Expense',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          )),
                      ButtonBarEntry(
                          onTap: expenseHomeCubit.onTapIncomeButtonBar,
                          child: const Text(
                            'Income',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          )),
                    ],
                  ),
            BlocProvider.value(
              value: BlocProvider.of<ExpenseHomeCubit>(context),
              child: BlocBuilder<ExpenseHomeCubit, ExpenseHomeState>(
                builder: (c, state) {
                  return Container(
                    width: 180,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    // padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            width: 1.5, color: CustomColors.background4)),
                    child: BlocProvider.value(
                      value: BlocProvider.of<ExpenseGoalCubit>(context),
                      child: BlocBuilder<ExpenseGoalCubit, ExpenseGoalState>(
                          builder: (context, state) {
                        var categories = pageType == PageType.goals
                            ? expenseGoalCubit.categories
                            : expenseHomeCubit.categories;
                        return DropdownButton(
                            hint: const Text('Category'),
                            underline: Container(),
                            icon: const Icon(Icons.arrow_drop_down),
                            isExpanded: false,
                            isDense: true,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            value: pageType == PageType.goals
                                ? expenseGoalCubit.selectedCategory
                                : expenseHomeCubit.selectedCategory,
                            dropdownColor: CustomColors.background1,
                            borderRadius: BorderRadius.circular(20),
                            items: categories
                                .map((code) => DropdownMenuItem(
                                    value: code['name'],
                                    child: Center(
                                      child: Text(
                                        code['name'].toString(),
                                        style: const TextStyle(
                                            fontSize: 16.5,
                                            fontWeight: FontWeight.w500,
                                            color: CustomColors.background4),
                                      ),
                                    )))
                                .toList(),
                            onChanged: (value) {
                              pageType == PageType.goals
                                  ? expenseGoalCubit
                                      .onChangedGoalCategory(value)
                                  : expenseHomeCubit.onChangedCategory(value);
                            });
                      }),
                    ),
                  );
                },
              ),
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  ExpenseTextFormField(
                    hintText:
                        pageType == PageType.goals ? 'Target Amount' : 'Amount',
                    controller: expenseHomeCubit.amountController,
                    icon: Icons.wallet,
                    validator: (value) => expenseHomeCubit.amountValidator(),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ExpenseTextFormField(
                    hintText: 'Notes',
                    controller: expenseHomeCubit.notesController,
                    icon: Icons.edit,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
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
                              color: CustomColors.background4, fontSize: 18),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: pageType == PageType.goals
                        ? () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              expenseGoalCubit.setExpenseGoals(
                                expenseHomeCubit.amountController.text,
                                expenseHomeCubit.notesController.text,
                              );
                              expenseHomeCubit.amountController.text = '';
                              expenseHomeCubit.notesController.text = '';
                              Navigator.pop(context);
                            }
                          }
                        : () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              expenseHomeCubit.saveRecord();

                              Navigator.pop(context);
                            }
                          },
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
                              color: CustomColors.background4, fontSize: 18),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
