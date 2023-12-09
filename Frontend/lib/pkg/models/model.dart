class ApiData{
  late String id;
  late String symbol;
  late String name;
  late String image;
  late int current_price;
  late int market_cap;
  late int market_cap_rank;
  late int fully_diluted_valuation;
  late int total_volume;
  late int high_24h;
  late int low_24h;
  late double price_change_24h;
  late double price_change_percentage_24h;
  late int market_cap_change_24h;
  late double market_cap_change_percentage_24h;
  late double circulating_supply;
  late double total_supply;
  late double max_supply;
  late int ath;
  late double ath_change_percentage;
  late String ath_date;
  late double atl;
  late double atl_change_percentage;
  late String atl_date;
  late dynamic roi;
  late String last_updated;
  late Sparkline sparkline_in_7d;
  late double price_change_percentage_24h_in_currency;

  ApiData({
      required this.id,
      required this.symbol,
      required this.name,
      required this.image,
      required this.current_price,
      required this.market_cap,
      required this.market_cap_rank,
      required this.fully_diluted_valuation,
      required this.total_volume,
      required this.high_24h,
      required this.low_24h,
      required this.price_change_24h,
      required this.price_change_percentage_24h,
      required this.market_cap_change_24h,
      required this.market_cap_change_percentage_24h,
      required this.circulating_supply,
      required this.total_supply,
      required this.max_supply,
      required this.ath,
      required this.ath_change_percentage,
      required this.ath_date,
      required this.atl,
      required this.atl_change_percentage,
      required this.atl_date,
      required this.roi,
      required this.last_updated,
      required this.sparkline_in_7d,
      required this.price_change_percentage_24h_in_currency
      });

  factory ApiData.fromJson(Map<String, dynamic> json) {
    return ApiData(
      id: json['id'] ?? '',
      symbol: json['symbol'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      current_price: json['current_price']?.toInt() ?? 0,
      market_cap: json['market_cap'] ?? 0,
      market_cap_rank: json['market_cap_rank'] ?? 0,
      fully_diluted_valuation: json['fully_diluted_valuation'] ?? 0,
      total_volume: json['total_volume']?.toInt() ?? 0,
      high_24h: json['high_24h']?.toInt() ?? 0,
      low_24h: json['low_24h']?.toInt() ?? 0,
      price_change_24h: json['price_change_24h']?? 0.0,
      price_change_percentage_24h: json['price_change_percentage_24h'] ?? 0.0,
      market_cap_change_24h: json['market_cap_change_24h']?.toInt()?? 0,
      market_cap_change_percentage_24h: json['market_cap_change_percentage_24h']?? 0.0,
      circulating_supply: json['circulating_supply'] ?? 0.0,
      total_supply: json['total_supply'] ?? 0.0,
      max_supply: json['max_supply'] ?? 0.0,
      ath: json['ath']?.toInt() ?? 0,
      ath_change_percentage: json['ath_change_percentage'] ?? 0.0,
      ath_date: json['ath_date'] ?? '',
      atl: json['atl'] ?? 0.0,
      atl_change_percentage: json['atl_change_percentage'] ?? 0.0,
      atl_date: json['atl_date'] ?? '',
      roi: json['roi'] ?? 0.0,
      last_updated: json['last_updated'] ?? '',
      sparkline_in_7d: Sparkline.fromJson(json['sparkline_in_7d'] ?? {}),
      price_change_percentage_24h_in_currency: json['price_change_percentage_24h_in_currency'] ?? 0.0,
    );
  }
}

class Sparkline{
  late List<dynamic> price;

  Sparkline({required this.price});

  factory Sparkline.fromJson(Map<String, dynamic>? json) {
    List<dynamic> sparklineData = (json?['price']??[]);
    return Sparkline(price: sparklineData);
  }
}