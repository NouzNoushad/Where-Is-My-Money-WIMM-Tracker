import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/core/colors.dart';
import 'package:expense_tracker/core/constants.dart';
import 'package:expense_tracker/model/expense_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

class ExpenseHomeService {
  saveRecord(expenseType, category, notes, amount, date, createdOn) async {
    String uid = const Uuid().v1();
    ExpenseModel expenseModel = ExpenseModel(
        uid: uid,
        expenseType: expenseType,
        category: category,
        notes: notes,
        amount: amount,
        date: date,
        createdOn: createdOn);
    await FirebaseFirestore.instance
        .collection(expenseDB)
        .doc(uid)
        .set(expenseModelToMap(expenseModel))
        .then((value) async {
      Fluttertoast.showToast(
          msg: 'Record added successfully',
          backgroundColor: CustomColors.background1,
          textColor: CustomColors.background4);
      print('////////////////// successful');
    }).catchError((err) {
      Fluttertoast.showToast(
          msg: 'Could not add your record',
          backgroundColor: CustomColors.background1,
          textColor: CustomColors.background4);
      print('Error occured: $err');
    });
  }

  deleteRecord(uid) async {
    FirebaseFirestore.instance
        .collection(expenseDB)
        .doc(uid)
        .delete()
        .then((value) {
      print('Record deleted');
      Fluttertoast.showToast(
          msg: 'Record deleted',
          backgroundColor: CustomColors.background1,
          textColor: CustomColors.background4);
    });
  }
}
