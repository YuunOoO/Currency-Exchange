import 'package:currency_exchange/bloc/currency_bloc/currency_bloc.dart';
import 'package:currency_exchange/pages/currency_page/currency_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Exchange',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => CurrencyBloc(),
        child: CurrencyPage(),
      ),
    );
  }
}
