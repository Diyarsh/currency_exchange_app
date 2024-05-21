import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyExchange {
  final String _apiKey = 'fca_live_4UJoJUfl653cNsppv41gfTw3ULV7zH2o7xfzXs13';
  final String _baseUrl = 'https://api.freecurrencyapi.com/v1/latest';

  Future<double> getExchangeRate(String fromCurrency, String toCurrency) async {
    final response = await http.get(
      Uri.parse('$_baseUrl?apikey=$_apiKey&currencies=$toCurrency&base_currency=$fromCurrency'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['data'] != null && data['data'][toCurrency] != null) {
        return data['data'][toCurrency].toDouble();
      } else {
        throw Exception('Exchange rate not available for $fromCurrency to $toCurrency');
      }
    } else {
      throw Exception('Failed to load exchange rate');
    }
  }
}


