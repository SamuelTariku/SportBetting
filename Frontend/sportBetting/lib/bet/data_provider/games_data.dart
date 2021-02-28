import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:flutter_network/bet/models/Fixture.dart';
import 'package:http/http.dart' as http;

class FixtureDataProvider {
  final _baseUrl = 'http://192.168.1.9:5000';
  final http.Client httpClient;

  FixtureDataProvider({@required this.httpClient}) : assert(httpClient != null);

  Future<Fixture> createGame(Fixture game) async {
    final response = await httpClient.post(
      Uri.http(_baseUrl, '/games'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'team_one': game.teamOne,
        'team_two': game.teamTwo
      }),
    );

    if (response.statusCode == 200) {
      return Fixture.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create bet.');
    }
  }

  Future<List<Fixture>> getGames() async {
    // try {
    final response = await httpClient.get('$_baseUrl/games');
    // }
    // catch(e) {
    //   print(e);
    // }

    if (response.statusCode == 200) {
      print("test");
      final games = jsonDecode(response.body) as List;
      return games.map((game) => Fixture.fromJson(game)).toList();
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
      throw Exception('Failed to load games.');
    }
  }

  Future<void> deleteGame(int id) async {
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

  Future<void> updateGame(Fixture game) async {
    final http.Response response = await httpClient.put(
      '$_baseUrl/bet/${game.id}',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': game.id,
        'team_one': game.teamOne,
        'team_two': game.teamTwo,
        'datetime': game.teamTwo,
      }),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to update bet.');
    }
  }
}
