import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'networking.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  int current = 0;
  String item = 'BCH';
  String name = "Bitcoin Cash";
  dynamic bitcoinValue;
  int btc = 52;
  List<Text> getItems() {
    List<Text> items = [];
    for (String currency in currenciesList) {
      items.add(Text(currency));
    }
    return items;
  }

  void getbtc() async {
    GetCurrencyData curr = GetCurrencyData();
    bitcoinValue = await curr.getData();
    setState(() {
      double bitcoin = bitcoinValue[current + 1]['rate'];
      name = bitcoinValue[current + 1]['name'];
      btc = bitcoin.toInt();
    });
  }

  @override
  Widget build(BuildContext context) {
    getbtc();
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $btc $item ($name)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: CupertinoPicker(
              itemExtent: 35.0,
              onSelectedItemChanged: (selectedIndex) {
                setState(() {
                  print(selectedIndex);
                  if (selectedIndex == 12) {
                    current = 73;
                    item = 'INR';
                  } else {
                    current = selectedIndex;
                    item = currenciesList[current];
                  }
                });
              },
              children: getItems(),
            ),
          ),
        ],
      ),
    );
  }
}
