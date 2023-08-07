GoalsModel goalsModelFromMap(Map<String, dynamic> data) =>
    GoalsModel.fromMap(data);

Map<String, dynamic> goalsModelToMap(GoalsModel data) => data.toMap();

class GoalsModel {
  String uid;
  String category;
  String notes;
  String amount;
  String image;
  double savings;
  double average;
  DateTime createdOn;

  GoalsModel({
    required this.uid,
    required this.category,
    required this.notes,
    required this.amount,
    required this.image,
    required this.createdOn,
    this.average = 0.0,
    this.savings = 0.0,
  });

  factory GoalsModel.fromMap(Map<String, dynamic> json) => GoalsModel(
      uid: json["uid"],
      category: json["category"],
      notes: json["notes"],
      amount: json["amount"],
      image: json["image"],
      average: json["average"],
      savings: json["savings"],
      createdOn: json["created_on"].toDate());

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "category": category,
        "notes": notes,
        "amount": amount,
        "image": image,
        "average": average,
        "savings": savings,
        "created_on": createdOn,
      };
}
