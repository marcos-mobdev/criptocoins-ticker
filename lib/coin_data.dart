import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

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
  String coinApiKey2 = "F10F43FE-1248-4637-8B45-9E2DBCD8FA32";
  Future<Map<String, dynamic>> getCoinData(String currency)async{

    Map<String, dynamic> cryptoPrices = {};

    for(String crypto in cryptoList){
      var url = Uri.https("rest.coinapi.io", "v1/exchangerate/$crypto/$currency", {'apikey': dotenv.env['COIN_API_KEY_2']});
      var response = await http.get(url);
      if(response.statusCode == 200){
        var result = jsonDecode(response.body);
        double price = result["rate"];
        cryptoPrices[crypto] = price.toStringAsFixed(0);
      }else{
        print("ERROR ${response.statusCode}");
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }


}
