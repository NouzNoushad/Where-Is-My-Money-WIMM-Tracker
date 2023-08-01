import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:expense_tracker/core/colors.dart';
import 'package:expense_tracker/expense_home/screens/home_app_bar.dart';
import 'package:flutter/material.dart';

class ExpenseHome extends StatelessWidget {
  const ExpenseHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  children: [
                    DatePicker(
                      DateTime.now(),
                      initialSelectedDate: DateTime.now(),
                      selectionColor: CustomColors.background4,
                      selectedTextColor: CustomColors.background1,
                      onDateChange: (date) {
                        // New date selected
                        print(date);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Container(
                    //   color: CustomColors.background2,
                    //   width: double.infinity,
                    //   padding:
                    //       const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    //   child: const Text(
                    //     'Aug 01, Tuesday',
                    //     style: TextStyle(
                    //         color: CustomColors.background4,
                    //         fontWeight: FontWeight.w500),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 6,
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
