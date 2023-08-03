import 'package:expense_tracker/core/colors.dart';
import 'package:expense_tracker/core/constants.dart';
import 'package:expense_tracker/expense_home/cubit/expense_home_cubit.dart';
import 'package:expense_tracker/expense_home/screens/expense_bottom_sheet.dart';
import 'package:expense_tracker/expense_home/screens/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseHome extends StatefulWidget {
  const ExpenseHome({super.key});

  @override
  State<ExpenseHome> createState() => _ExpenseHomeState();
}

class _ExpenseHomeState extends State<ExpenseHome> {
  // final CalendarFormat _calendarFormat = CalendarFormat.month;
  // final DateTime _focusedDay = DateTime.now();
  // DateTime? _selectedDay;
  late ExpenseHomeCubit expenseHomeCubit;
  @override
  void initState() {
//     List<DateTime> getDaysInBetween(DateTime startDate, DateTime endDate) {
//       List<DateTime> days = [];
//       for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
//         days.add(startDate.add(Duration(days: i)));
//       }
//       return days;
//     }

// // try it out
//     DateTime startDate = DateTime(2023, 5, 5).toUtc();
//     DateTime endDate = DateTime(2023, 8, 15).toUtc();

//     List<DateTime> days = getDaysInBetween(startDate, endDate);

//     // print the result without time
//     for (var day in days) {
//       print(day.toUtc().toString().split(' ')[0]);
//     }
    expenseHomeCubit = BlocProvider.of<ExpenseHomeCubit>(context);
    expenseHomeCubit.initDate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showExpenseBottomSheet(context, expenseHomeCubit);
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
                        return Row(
                          children: [
                            Expanded(
                              child: IconButton(
                                onPressed: () {
                                  expenseHomeCubit
                                      .swipeDate(DateState.previous);
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
                        );
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      color: CustomColors.background2,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      child: const Text(
                        'Aug 01, Tuesday',
                        style: TextStyle(
                            color: CustomColors.background4,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ...List.generate(
                        10,
                        (index) => Column(
                              children: [
                                Container(
                                    // color: Colors.yellow,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 0),
                                    child: const Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 24,
                                          backgroundColor:
                                              CustomColors.background4,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Car',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text('Fuel')
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '-50.00',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    )),
                                index != 9
                                    ? const Divider(
                                        color: CustomColors.background2,
                                      )
                                    : Container(),
                              ],
                            )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
