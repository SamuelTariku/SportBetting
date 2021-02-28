import 'package:meta/meta.dart';
import 'package:flutter_network/bet/bet.dart';

class FixtureRepository {
  final FixtureDataProvider dataProvider;

  FixtureRepository({@required this.dataProvider})
      : assert(dataProvider != null);

  Future<Fixture> createGame(Fixture game) async {
    return await dataProvider.createGame(game);
  }

  Future<List<Fixture>> getGames() async {
    return await dataProvider.getGames();
  }

  Future<void> updateGame(Fixture game) async {
    await dataProvider.updateGame(game);
  }

  Future<void> deleteGames(int id) async {
    await dataProvider.deleteGame(id);
  }
}
