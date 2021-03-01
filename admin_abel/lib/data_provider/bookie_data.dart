import 'dart:convert';
import 'package:admin_abel/models/bookie.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class BookieDataProvider {
  final _baseUrl = 'http://192.168.1.9:5000';
  final http.Client httpClient;

  BookieDataProvider({@required this.httpClient}) : assert(httpClient != null);

  Future<Bookie> createBookieBet(Bookie bet) async {
    final response = await httpClient.post(
      Uri.http(_baseUrl, '/bookie'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, dynamic>{'game_id': bet.gameID, 'datetime': bet.datetime}),
    );

    if (response.statusCode == 200) {
      return Bookie.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create bet.');
    }
  }

  Future<List<Bookie>> getBookieBets() async {
    // try {
    final response = await httpClient.get('$_baseUrl/bookie');
    // }
    // catch(e) {
    //   print(e);
    // }

    if (response.statusCode == 200) {
     // print(response.body);
      final bookieBets = jsonDecode(response.body) as List;
      return bookieBets.map((bet) => Bookie.fromJson(bet)).toList();
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

  Future<List<Bookie>> getBookieBetsByGame(int gameID) async {
    // try {
    final response = await httpClient.get('$_baseUrl/bookie/game/$gameID');
    // }
    // catch(e) {
    //   print(e);
    // }

    if (response.statusCode == 200) {
      print("test");
      final bookieBets = jsonDecode(response.body) as List;
      return bookieBets.map((bet) => Bookie.fromJson(bet)).toList();
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

  Future<void> deleteBookieBet(String id) async {
    final http.Response response = await httpClient.delete(
      '$_baseUrl/bookie/$id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete bets.');
    }
  }

  Future<void> updateBookieBet(Bookie bookieBet) async {
    final http.Response response = await httpClient.put(
      '$_baseUrl/bookie/${bookieBet.id}',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': bookieBet.id,
        'game_id': bookieBet.gameID,
        'outcome': bookieBet.outcome,
      }),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to update bet.');
    }
  }
}