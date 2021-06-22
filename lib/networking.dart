import 'dart:convert';

import 'package:http/http.dart' as http;

class GetCurrencyData {
  Future<dynamic> getData() async {
    http.Response response = await http.get(
      Uri.parse("https://bitpay.com/api/rates"),
    );
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
