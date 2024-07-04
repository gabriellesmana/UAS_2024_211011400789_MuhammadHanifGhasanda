import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/crypto_provider.dart';

class CryptoListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.network(
              'https://tse2.mm.bing.net/th?id=OIP.U3TETGEJgmMJDVXCrSQzNgHaE7&pid=Api&P=0&h=180',
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 8),
            Text(
              'Hanip Store',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background_pattern.png'), // Ganti dengan path gambar motif atau pola
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken), // Efek gelapkan gambar jika perlu
          ),
        ),
        child: FutureBuilder(
          future: Provider.of<CryptoProvider>(context, listen: false).fetchCryptos(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return Consumer<CryptoProvider>(
                builder: (ctx, cryptoProvider, _) => SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columnSpacing: 10,
                      columns: const <DataColumn>[
                        DataColumn(label: Text('#', style: TextStyle(fontWeight: FontWeight.bold))),
                        DataColumn(label: Text('Nama', style: TextStyle(fontWeight: FontWeight.bold))),
                        DataColumn(label: Text('Harga', style: TextStyle(fontWeight: FontWeight.bold))),
                        DataColumn(label: Text('Perubahan 1 Jam', style: TextStyle(fontWeight: FontWeight.bold))),
                        DataColumn(label: Text('Perubahan 24 Jam', style: TextStyle(fontWeight: FontWeight.bold))),
                        DataColumn(label: Text('Perubahan 7 Hari', style: TextStyle(fontWeight: FontWeight.bold))),
                        DataColumn(label: Text('Market Cap', style: TextStyle(fontWeight: FontWeight.bold))),
                        DataColumn(label: Text('Volume (24 Jam)', style: TextStyle(fontWeight: FontWeight.bold))),
                        DataColumn(label: Text('Suplai Beredar', style: TextStyle(fontWeight: FontWeight.bold))),
                      ],
                      rows: cryptoProvider.cryptos.map((crypto) {
                        return DataRow(cells: [
                          DataCell(Text(crypto.rank.toString())),
                          DataCell(
                            Row(
                              children: [
                                Image.network(
                                  crypto.logoUrl,
                                  width: 24,
                                  height: 24,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(Icons.error, size: 24, color: Colors.grey); // Placeholder jika logo gagal dimuat
                                  },
                                ),
                                SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      crypto.name,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      crypto.symbol,
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          DataCell(
                            Text(
                              '\$${crypto.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              '${crypto.change1h.toStringAsFixed(2)}%',
                              style: TextStyle(
                                color: crypto.change1h >= 0 ? Colors.green : Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              '${crypto.change24h.toStringAsFixed(2)}%',
                              style: TextStyle(
                                color: crypto.change24h >= 0 ? Colors.green : Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              '${crypto.change7d.toStringAsFixed(2)}%',
                              style: TextStyle(
                                color: crypto.change7d >= 0 ? Colors.green : Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              '\$${crypto.marketCap.toStringAsFixed(2)}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataCell(
                            Text(
                              '\$${crypto.volume24h.toStringAsFixed(2)}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataCell(
                            Text(
                              '${crypto.circulatingSupply.toStringAsFixed(2)} ${crypto.symbol}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ]);
                      }).toList(),
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
