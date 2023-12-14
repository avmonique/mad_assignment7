import 'package:ave_assignment7/models/expenses_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpensesListScreen extends StatefulWidget {
  ExpensesListScreen({super.key});

  @override
  State<ExpensesListScreen> createState() => _ExpensesListScreenState();
}

class _ExpensesListScreenState extends State<ExpensesListScreen> {
  List<ExpensesItem> items = [];

  var itemController = TextEditingController();
  var descController = TextEditingController();
  var amountController = TextEditingController();
  var amount_formatter = NumberFormat.currency(
    symbol: '',
    decimalDigits: 2,
  );

  void insertItem() {
    String nums = "1234567890";
    String newItem = itemController.text;
    String desc = descController.text;
    String amt = amountController.text;

    if (newItem.isEmpty || desc.isEmpty || amt.isEmpty) {
      _showAlertDialog("Error", "Please fill in all fields.");
      return;
    }

    if (amt.split("").any((char) => !nums.contains(char))) {
      _showAlertDialog("Error", "Invalid amount. Please enter a valid number.");
      return;
    }

    double amount = double.parse(amt);

    if (items.any((item) =>
        item.item == newItem &&
        item.description == desc &&
        item.amount == amount)) {
      _showAlertDialog(
          "Error", "Duplicate entry. This item already exists.");
      return;
    }

    setState(() {
      items.insert(
          0, ExpensesItem(item: newItem, description: desc, amount: amount));
    });

    itemController.clear();
    descController.clear();
    amountController.clear();
  }

  void _showAlertDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Future<bool?> _confirmDismiss(DismissDirection direction, int index) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Delete"),
          content: const Text("Are you sure you want to delete this item?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text("DELETE"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("CANCEL"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "My Expenses",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              const SizedBox(height: 5,),
              Card(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextField(
                            controller: itemController,
                            decoration: const InputDecoration(
                              labelText: "Expenses Item",
                            ),
                          ),
                          TextField(
                            controller: descController,
                            decoration: const InputDecoration(
                              labelText: "Description",
                            ),
                          ),
                          TextField(
                            controller: amountController,
                            decoration: const InputDecoration(
                              labelText: "Amount",
                            ),
                          ),
                          const SizedBox(height: 10,),
                          ElevatedButton(
                            onPressed: insertItem,
                            child: const Text("ADD ITEM"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key(items[index].item),
                      direction: DismissDirection.startToEnd,
                      confirmDismiss: (direction) async =>
                          _confirmDismiss(direction, index),
                      onDismissed: (direction) {
                        setState(() {
                          items.removeAt(index);
                        });
                      },
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(10),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      child: Card(
                        child: ListTile(
                          title: Text(
                            items[index].item,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          subtitle: Text(
                            items[index].description,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          trailing: Container(
                            decoration: BoxDecoration(
                              border: Border.all(),
                            ),
                            padding: const EdgeInsets.all(5),
                            child: Text(amount_formatter.format(items[index].amount),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}