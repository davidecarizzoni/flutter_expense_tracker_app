import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  //important: remove textEditingController on modalClose
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  void _addExpense() {
    print(_titleController.text);
  }

  void _closeModal() {
    Navigator.pop(context);
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
      padding: const EdgeInsets.symmetric(horizontal: 10),
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
          TextField(
            keyboardType: TextInputType.number,
            controller: _amountController,
            decoration: const InputDecoration(
              label: Text('Amount'),
              prefix: Text('\$'),
            ),
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
