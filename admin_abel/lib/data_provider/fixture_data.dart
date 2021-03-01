import 'dart:convert';
import 'package:meta/meta.dart';
import '../models/fixture.dart';
import 'package:http/http.dart' as http;

class FixtureDataProvider {
  final _baseUrl = 'http://192.168.1.9:5000';
  final http.Client httpClient;

  FixtureDataProvider({@required this.httpClient}) : assert(httpClient != null);

  Future<Fixture> createFixture(Fixture fix) async {
    final response = await httpClient.post(
      Uri.http(_baseUrl, '/games'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'teamone': fix.teamOne,
        'teamtwo': fix.teamTwo,
        'time': fix.time,
        'homeodd': fix.homeOdd,
        'awayodd': fix.awayOdd,
        'drawodd': fix.drawOdd,
        'firstteamodd': fix.firstTeamOdd,
        'secondteamodd': fix.secondTeamOdd,
      }),
    );

    if (response.statusCode == 200) {
      return Fixture.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create fixture.');
    }
  }

  Future<List<Fixture>> getFixtures() async {
    final response = await httpClient.get('$_baseUrl/games');

    if (response.statusCode == 200) {
      final fixture = jsonDecode(response.body) as List;
      print(fixture);
      return fixture.map((fixture) => Fixture.fromJson(fixture)).toList();
    } else {
      print("error 12212 23 23 23");
      throw Exception('Failed to load fixtures');
    }
  }

  Future<void> deleteFixture(String id) async {
    final http.Response response = await httpClient.delete(
      '$_baseUrl/fixture/$id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete fixture.');
    }
  }

  Future<void> updateFixture(Fixture fix) async {
    final http.Response response = await httpClient.put(
      '$_baseUrl/fixture/${fix.id}',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': fix.id,
        'teamone': fix.teamOne,
        'teamtwo': fix.teamTwo,
        'time': fix.time,
        // 'homeodd': fix.homeOdd,
        // 'awayodd': fix.awayOdd,
        // 'drawodd': fix.drawOdd,
        // 'firstteamodd': fix.firstTeamOdd,
        // 'secondteamodd': fix.secondTeamOdd,
      }),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to update fixture.');
    }
  }
}
