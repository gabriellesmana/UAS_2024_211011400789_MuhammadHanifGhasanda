class Crypto {
  final int rank;
  final String name;
  final String symbol;
  final double price;
  final double change1h;
  final double change24h;
  final double change7d;
  final double marketCap;
  final double volume24h;
  final double circulatingSupply;
  final String logoUrl; // Tambahkan field untuk URL logo

  Crypto({
    required this.rank,
    required this.name,
    required this.symbol,
    required this.price,
    required this.change1h,
    required this.change24h,
    required this.change7d,
    required this.marketCap,
    required this.volume24h,
    required this.circulatingSupply,
    required this.logoUrl, // Inisialisasi field logoUrl
  });

  factory Crypto.fromJson(Map<String, dynamic> json) {
    final symbol = json['symbol'].toString().toLowerCase();
    final logoUrl = 'https://cryptoicons.org/api/icon/$symbol/200'; // Contoh URL dari CryptoIcons
    return Crypto(
      rank: json['rank'] ?? 0,
      name: json['name'] ?? '',
      symbol: json['symbol'] ?? '',
      price: json['price_usd'] != null ? double.parse(json['price_usd']) : 0.0,
      change1h: json['percent_change_1h'] != null ? double.parse(json['percent_change_1h']) : 0.0,
      change24h: json['percent_change_24h'] != null ? double.parse(json['percent_change_24h']) : 0.0,
      change7d: json['percent_change_7d'] != null ? double.parse(json['percent_change_7d']) : 0.0,
      marketCap: json['market_cap_usd'] != null ? double.parse(json['market_cap_usd']) : 0.0,
      volume24h: json['24h_volume_usd'] != null ? double.parse(json['24h_volume_usd']) : 0.0,
      circulatingSupply: json['csupply'] != null ? double.parse(json['csupply']) : 0.0,
      logoUrl: logoUrl, // Assign URL logo ke field logoUrl
    );
  }
}
