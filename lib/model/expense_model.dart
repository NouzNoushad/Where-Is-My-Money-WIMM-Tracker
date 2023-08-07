ExpenseModel expenseModelFromMap(Map<String, dynamic> data) =>
    ExpenseModel.fromMap(data);

Map<String, dynamic> expenseModelToMap(ExpenseModel data) => data.toMap();

class ExpenseModel {
  String uid;
  String expenseType;
  String category;
  String notes;
  String amount;
  String date;
  String image;
  DateTime createdOn;

  ExpenseModel({
    required this.uid,
    required this.expenseType,
    required this.category,
    required this.notes,
    required this.amount,
    required this.date,
    required this.image,
    required this.createdOn,
  });

  factory ExpenseModel.fromMap(Map<String, dynamic> json) => ExpenseModel(
      uid: json["uid"],
      expenseType: json["expense_type"],
      category: json["category"],
      notes: json["notes"],
      amount: json["amount"],
      date: json["date"],
      image: json["image"],
      createdOn: json["created_on"].toDate());

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "expense_type": expenseType,
        "category": category,
        "notes": notes,
        "amount": amount,
        "date": date,
        "image": image,
        "created_on": createdOn,
      };
}
