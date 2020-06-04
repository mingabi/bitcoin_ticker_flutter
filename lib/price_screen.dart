import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'crypto_card.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  Map<String, String> coinMap = {};

  DropdownButton<String> getDropdownButton() {
    List<DropdownMenuItem<String>> dropdownItems = [];

    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        print(value);
        setState(
          () {
            selectedCurrency = value;
            getData();
          },
        );
      },
    );
  }

  CupertinoPicker getCupertinoPicker() {
    List<Text> pickerItems = [];

    for (String currency in currenciesList) {
      var newItem = Text(currency);
      pickerItems.add(newItem);
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32,
      onSelectedItemChanged: (selectedIndex) {
        selectedCurrency = currenciesList[selectedIndex];
        getData();
      },
      children: pickerItems,
    );
  }

  Column getCryptoList() {
    List<Widget> list = [];
    CoinData coinData = CoinData();
    coinData.getCoinData(selectedCurrency);
    for (String crypto in cryptoList) {
      var newItem = CryptoCard(
          crypto: crypto,
          cryptoRate: coinMap[crypto],
          currency: selectedCurrency);
      list.add(newItem);
    }
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, children: list);
  }

  void getData() async {
    CoinData coinData = CoinData();
    var data = await coinData.getCoinData(selectedCurrency);
    setState(() {
      coinMap = data;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          getCryptoList(),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child:
                Platform.isAndroid ? getDropdownButton() : getCupertinoPicker(),
          ),
        ],
      ),
    );
  }
}
