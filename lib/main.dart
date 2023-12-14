import 'package:ave_assignment7/screens/expenses_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {

    final colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.purple,
    );

    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        cardTheme: const CardTheme(
          elevation: 4,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          titleMedium: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          titleSmall: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: ExpensesListScreen(),
    );
  }
}