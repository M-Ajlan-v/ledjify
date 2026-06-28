import 'package:flutter/material.dart';
import 'package:ledjify/helpers/transaction_helpers.dart';
import 'package:provider/provider.dart';

import 'helpers/cashbook_helpers.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CashbookHelper()),
          ChangeNotifierProvider(create: (_) => TransactionHelper()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}