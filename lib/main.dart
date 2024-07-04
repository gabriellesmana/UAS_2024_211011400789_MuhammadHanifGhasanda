// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/crypto_provider.dart';
import './screens/crypto_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => CryptoProvider()),
      ],
      child: MaterialApp(
        title: 'Crypto Prices',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: CryptoListScreen(),
      ),
    );
  }
}
