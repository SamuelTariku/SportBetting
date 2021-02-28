import 'dart:convert';
import 'package:meta/meta.dart';
import '../bet.dart';
import 'package:http/http.dart' as http;

class ForBetDataProvider {
  final _baseUrl = 'http://192.168.1.9:5000';
  final http.Client httpClient;

  ForBetDataProvider({@required this.httpClient}) : assert(httpClient != null);

  Future<ForBet> createBet(ForBet bet) async {
    final response = await httpClient.post(
      Uri.http(_baseUrl, '/bets'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'userid': bet.userID,
        'balance': bet.balance,
        'amount': bet.amount,
        'outcome': bet.outcome,
        'winstatus': bet.winStatus,
      }),
    );

    if (response.statusCode == 200) {
      return ForBet.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create bet.');
    }
    
  }

  Future<List<ForBet>> getBets() async {
    // try {
    final response = await httpClient.get('$_baseUrl/bets');
    if (response.statusCode == 200) {
      final bet = jsonDecode(response.body) as List;
      return bet.map((bet) => ForBet.fromJson(bet)).toList();
      // var betting = new List(bet.length);
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

    if (response.statusCode != 204) {
      throw Exception('Failed to delete bets.');
    }
  }

  Future<void> updateBet(ForBet bet) async {
    final http.Response response = await httpClient.put(
      '$_baseUrl/bet/${bet.id}',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': bet.id,
        'userid': bet.userID,
        'balance': bet.balance,
        'amount': bet.amount,
        'outcome': bet.outcome,
      }),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to update bet.');
    }
  }
}
