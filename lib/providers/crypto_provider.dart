import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/crypto.dart';

class CryptoProvider with ChangeNotifier {
  List<Crypto> _cryptos = [];

  List<Crypto> get cryptos {
    return [..._cryptos];
  }

  Future<void> fetchCryptos() async {
    final url = Uri.parse('https://api.coinlore.net/api/tickers/');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body)['data'] as List<dynamic>;
      final List<Crypto> loadedCryptos = [];
      for (var cryptoData in extractedData) {
        final symbol = cryptoData['symbol'].toString().toLowerCase();
        final logoUrl = 'https://cryptoicons.org/api/icon/$symbol/200'; // URL logo dari CryptoIcons (ganti sesuai sumber logo yang Anda gunakan)
        loadedCryptos.add(Crypto.fromJson({
          ...cryptoData,
          'logoUrl': logoUrl, // Pastikan field 'logoUrl' terdapat di dalam JSON
        }));
      }
      _cryptos = loadedCryptos;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
