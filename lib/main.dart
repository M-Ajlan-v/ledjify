import 'package:flutter/material.dart';
import 'package:ledjify/providers/transaction_provider.dart';
import 'package:provider/provider.dart';

import 'providers/cashbook_provider.dart';
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
          create: (_) => CashbookProvider()),
          ChangeNotifierProvider(create: (_) => TransactionProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}