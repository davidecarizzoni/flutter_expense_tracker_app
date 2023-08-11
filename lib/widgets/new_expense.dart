import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  NewExpense({super.key, required this.addExpense});

  Function addExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  //important: remove textEditingController on modalClose
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  CategoryEnum? _category;
  DateTime? _date;

  void _addExpense() {
    final titleIsValid = _titleController.text.trim().isNotEmpty;
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsValid = enteredAmount != null && enteredAmount > 0;
    final dateIsValid = _date != null;
    final categoryIsValid = _category != null;
    if (amountIsValid && dateIsValid && categoryIsValid && titleIsValid) {
      Expense newExpense = Expense(
          title: _titleController.text,
          amount: enteredAmount,
          date: _date as DateTime,
          category: _category as CategoryEnum);
      widget.addExpense(newExpense);
      _closeModal();
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text('Please enter valid data'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Ok'),
            )
          ],
        ),
      );
    }
  }

  void _closeModal() {
    Navigator.pop(context);
  }

  void _openDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final picketData = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _date = picketData as DateTime;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
      child: ListView(
        children: [
          Row(
            children: [
              const Spacer(),
              IconButton(
                onPressed: _closeModal,
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          TextField(
            maxLength: 50,
            keyboardType: TextInputType.text,
            controller: _titleController,
            decoration: const InputDecoration(label: Text('Title')),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _amountController,
                  decoration: const InputDecoration(
                    label: Text('Amount'),
                    prefix: Text('\$'),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(_date == null
                        ? 'No date selected'
                        : formatter.format(_date as DateTime)),
                    IconButton(
                      onPressed: _openDatePicker,
                      icon: const Icon(
                        Icons.calendar_month,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: DropdownButton(
                  value: _category,
                  items: CategoryEnum.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(
                            category.name.toUpperCase(),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _category = value;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _addExpense,
                child: const Text('Save'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
