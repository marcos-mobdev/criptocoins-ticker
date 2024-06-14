import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CoinData coinData = CoinData();
  Map<String,dynamic> coinValues={};
  bool isWaiting = true;

  void getData()async {
    isWaiting = true;
    try{
      var data = await CoinData().getCoinData(selectedCurrency);
      isWaiting = false;
      setState(() {
        coinValues = data;
      });
    }catch(e){
      print(e);
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }


  String selectedCurrency = "USD";

  List<DropdownMenuItem<String>> getDropdownItems() {
    List<DropdownMenuItem<String>> dropdownItems = [];

    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }
    return dropdownItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CryptoCard(crypto: cryptoList[0], rate: isWaiting?"?":coinValues[cryptoList[0]], selectedCurrency: selectedCurrency),
          CryptoCard(crypto: cryptoList[1], rate: isWaiting?"?":coinValues[cryptoList[1]], selectedCurrency: selectedCurrency),
          CryptoCard(crypto: cryptoList[2], rate: isWaiting?"?":coinValues[cryptoList[2]], selectedCurrency: selectedCurrency),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: DropdownButton<String>(
                value: selectedCurrency,
                items: getDropdownItems(),
                onChanged: (String? value) {
                  setState(() {
                    selectedCurrency = value!;
                    getData();
                  });
                }),
          ),
        ],
      ),
    );
  }
}



class CryptoCard extends StatefulWidget {
  final String crypto;
  final String rate;
  final String selectedCurrency;


  CryptoCard({required this.crypto, required this.rate, required this.selectedCurrency});

  @override
  _CryptoCardState createState() => _CryptoCardState();
}

class _CryptoCardState extends State<CryptoCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 28),
          child: Text(
            '1 ${widget.crypto} = ${widget.rate} ${widget.selectedCurrency}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

