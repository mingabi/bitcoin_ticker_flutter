import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

const apiKey = 'API_KEY';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future getCoinData(String currency) async {
    Map<String, String> cryptoData = {};
    for (String crypto in cryptoList) {
      String url =
          'https://rest.coinapi.io/v1/exchangerate/$crypto/$currency?apiKey=$apiKey';
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        double rate = jsonResponse['rate'];
        cryptoData[crypto] = rate.toStringAsFixed(0);
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    }
    return cryptoData;
  }
}
