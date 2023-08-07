import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/colors.dart';
import '../cubit/expense_analysis_cubit.dart';

class ExpensePieChart extends StatefulWidget {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> expenseSnapshot;
  final Map<String, double> groupRecord;
  final double groupTotal;
  final List<Color> colors;
  const ExpensePieChart(
      {super.key,
      required this.expenseSnapshot,
      required this.groupRecord,
      required this.groupTotal,
      required this.colors});

  @override
  State<ExpensePieChart> createState() => _ExpensePieChartState();
}

class _ExpensePieChartState extends State<ExpensePieChart> {
  int touchedIndex = -1;
  late ExpenseAnalysisCubit expenseAnalysisCubit;
  @override
  void initState() {
    expenseAnalysisCubit = BlocProvider.of<ExpenseAnalysisCubit>(context);
    // expenseAnalysisCubit.groupByCategory(widget.expenseSnapshot);
    super.initState();
  }

  @override
  void dispose() {
    expenseAnalysisCubit.groupExpense = {};
    expenseAnalysisCubit.groupIncome = {};
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: PieChart(
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      touchedIndex = -1;
                      return;
                    }
                    touchedIndex =
                        pieTouchResponse.touchedSection!.touchedSectionIndex;
                  });
                },
              ),
              borderData: FlBorderData(
                show: false,
              ),
              sectionsSpace: 0,
              centerSpaceRadius: 40,
              sections: showingSections(),
            ),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ...List.generate(widget.groupRecord.length, (index) {
                var groupExpenseKey = widget.groupRecord.keys.toList()[index];
                return Column(
                  children: [
                    Indicator(
                      color: widget.colors[index],
                      text: groupExpenseKey,
                      isSquare: true,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
        const SizedBox(
          width: 28,
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(widget.groupRecord.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 15.0;
      final radius = isTouched ? 60.0 : 55.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      var groupValue = widget.groupRecord.values.toList()[i];
      var value =
          expenseAnalysisCubit.findAverageValue(groupValue, widget.groupTotal);
      return PieChartSectionData(
        color: widget.colors[i],
        value: value,
        title: '$value%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: CustomColors.background1,
          shadows: shadows,
        ),
      );
    });
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 15,
    this.textColor,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          text,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: CustomColors.background4,
          ),
        )
      ],
    );
  }
}
