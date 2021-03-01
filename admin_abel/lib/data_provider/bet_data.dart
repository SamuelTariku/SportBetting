import 'dart:convert';
import 'package:admin_abel/models/bet.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class BetDataProvider {
  final _baseUrl = 'http://192.168.1.9:5000';
  final http.Client httpClient;

  BetDataProvider({@required this.httpClient}) : assert(httpClient != null);

  Future<Bet> createBet(Bet bet) async {
    final response = await httpClient.post(
      Uri.http(_baseUrl, '/bets'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'userid': bet.userID,
        'bookieid': bet.bookieID,
        'amount': bet.amount,
        'outcome': bet.outcome,
      }),
    );

    if (response.statusCode == 200) {
      return Bet.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create bet.');
    }
  }

  Future<List<Bet>> getBets() async {
    // try {
    final response = await httpClient.get('$_baseUrl/bets');
    // }
    // catch(e) {
    //   print(e);
    // }

    if (response.statusCode == 200) {
      final bet = jsonDecode(response.body) as List;
      return bet.map((bet) => Bet.fromJson(bet)).toList();
      // var betting = new List(bet.length);
      // for (var value in bet) {
      //   print(value);
      //   betting.add(Bet.fromJson(value));
      //   print(betting.toString());
      // }
      // print(betting.toString());
      // return betting;
    } else {
      print("failed");
      throw Exception('Failed to load bets.');
    }
  }

  Future<void> deleteBets(String id) async {
    final http.Response response = await httpClient.delete(
      '$_baseUrl/bets/$id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    print("Delete statuscode" + response.statusCode.toString());

    if (response.statusCode != 200) {
      throw Exception('Failed to delete bets.');
    }
  }

  Future<void> updateBet(Bet bet) async {
    final http.Response response = await httpClient.put(
      '$_baseUrl/bets/${bet.id}',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': bet.id,
        'userid': bet.userID,
        'bookieid': bet.bookieID,
        'amount': bet.amount,
        'outcome': bet.outcome,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update bet.');
    }
  }
}
