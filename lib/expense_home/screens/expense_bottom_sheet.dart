import 'package:animated_button_bar/animated_button_bar.dart';
import 'package:expense_tracker/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/custom_text_field.dart';
import '../cubit/expense_home_cubit.dart';

showExpenseBottomSheet(
    BuildContext context, ExpenseHomeCubit expenseHomeCubit, formKey) {
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
            AnimatedButtonBar(
              backgroundColor: CustomColors.background3,
              foregroundColor: CustomColors.background4,
              radius: 8.0,
              invertedSelection: true,
              children: [
                ButtonBarEntry(
                    onTap: expenseHomeCubit.onTapExpenseButtonBar,
                    child: const Text(
                      'Expense',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    )),
                ButtonBarEntry(
                    onTap: expenseHomeCubit.onTapIncomeButtonBar,
                    child: const Text(
                      'Income',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    )),
              ],
            ),
            BlocProvider.value(
              value: BlocProvider.of<ExpenseHomeCubit>(context),
              child: BlocBuilder<ExpenseHomeCubit, ExpenseHomeState>(
                builder: (context, state) {
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
                        items: expenseHomeCubit.categories
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
                        onChanged: (value) {
                          expenseHomeCubit.onChangedCategory(value);
                        }),
                  );
                },
              ),
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  ExpenseTextFormField(
                    hintText: 'Amount',
                    controller: expenseHomeCubit.amountController,
                    icon: Icons.wallet,
                    validator: (value) =>
                        expenseHomeCubit.amountValidator(value!),
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
                              color: CustomColors.background4, fontSize: 18),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
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
