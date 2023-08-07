import 'package:flutter/material.dart';

enum DateState { next, previous }

enum ExpenseType { income, expense }

enum PageType { record, analysis, goals }

String expenseDB = 'expenses';
String goalsDB = 'goals';

List<Map<String, String>> expenseCategory = [
  {
    'name': 'Shopping',
    'image': 'trolley.png',
  },
  {
    'name': 'Food',
    'image': 'burger.png',
  },
  {
    'name': 'Clothing',
    'image': 'shirt.png',
  },
  {
    'name': 'Health',
    'image': 'heartbeat.png',
  },
  {
    'name': 'Home',
    'image': 'house.png',
  },
  {
    'name': 'Travel',
    'image': 'travel.png',
  },
  {
    'name': 'Entertainment',
    'image': 'popcorn.png',
  },
];

List<Map<String, String>> incomeCategory = [
  {
    'name': 'Cash',
    'image': 'money.png',
  },
  {
    'name': 'Savings',
    'image': 'piggy-bank.png',
  },
  {
    'name': 'Card',
    'image': 'atm-card.png',
  },
];

List<Color> expenseColors = [
  Colors.red,
  Colors.purple,
  Colors.teal,
  Colors.pink,
  Colors.cyan,
  Colors.orange,
  Colors.brown,
];

List<Color> incomeColors = [
  Colors.green,
  Colors.indigo,
  Colors.lime,
];
