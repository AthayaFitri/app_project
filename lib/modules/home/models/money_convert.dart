// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyData {
  final Map<String, CurrencyConvert> data;

  CurrencyData({required this.data});

  factory CurrencyData.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> currencyData = json['data'];
    Map<String, CurrencyConvert> currencies = Map.from(currencyData).map(
      (key, value) => MapEntry(
        key,
        CurrencyConvert.fromJson(value),
      ),
    );

    return CurrencyData(data: currencies);
  }
}

class CurrencyConvert {
  final String code;
  final double value;

  CurrencyConvert({required this.code, required this.value});

  factory CurrencyConvert.fromJson(Map<String, dynamic> json) {
    return CurrencyConvert(
      code: json['code'],
      value: json['value'].toDouble(),
    );
  }
}

class CurrencyConverter {
  Future<double> convertCurrency(String toCurrency, double amount) async {
    String apiUrl =
        'https://api.currencyapi.com/v3/latest?apikey=cur_live_29PeVIx3DJR19EY3LDIkg2pwPzPu5GDNy97PaTzJ';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        CurrencyData currencyData =
            CurrencyData.fromJson(json.decode(response.body));
        double exchangeRate = currencyData.data[toCurrency]!.value;
        print('Exchange Rate for $toCurrency: $exchangeRate');
        double convertedAmount = amount * exchangeRate;
        print('Converted Amount: $convertedAmount');
        return convertedAmount;
      } else {
        throw Exception('Failed to load exchange rates');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to convert currency');
    }
  }
}
