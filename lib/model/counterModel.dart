
import 'dart:convert';

List<CounterModel> sharepreferenceFromJson(String str) => List<CounterModel>.from(json.decode(str).map((x) => CounterModel.fromJson(x)));

String sharepreferenceToJson(List<CounterModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CounterModel {
  CounterModel({
    required this.name,
    required this.quantity,
  });

  String name;
  int quantity;

  factory CounterModel.fromJson(Map<String, dynamic> json) => CounterModel(
    name: json["Name"],
    quantity: json["Quantity"],
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "Quantity": quantity,
  };
}