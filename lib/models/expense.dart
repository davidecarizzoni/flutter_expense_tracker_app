import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final formatter = DateFormat.yMd();

enum CategoryEnum { food, travel, leisure, work }

const categoryIcons = {
  CategoryEnum.food: Icons.lunch_dining,
  CategoryEnum.travel: Icons.flight_takeoff,
  CategoryEnum.leisure: Icons.movie,
  CategoryEnum.work: Icons.work,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String title;
  final String id;
  final double amount;
  final DateTime date;
  final CategoryEnum category;

  get formattedData {
    return formatter.format(date);
  }

  get icon {
    return categoryIcons[category];
  }
}
