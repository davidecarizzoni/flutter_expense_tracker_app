import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  String _title = '';
  void _onChangeTitle(String value) {
    // i don't need to use set state because the UI doesn't need to be updated on every keystroke
    _title = value;
  }

  void _addExpense() {
    print(_title);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          TextField(
            onChanged: _onChangeTitle,
            maxLength: 50,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(label: Text('Title')),
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
