import 'package:meta/meta.dart';
import 'package:flutter_network/bet/bet.dart';

class BookieRepository {
  final BookieDataProvider dataProvider;

  BookieRepository({@required this.dataProvider})
      : assert(dataProvider != null);

  Future<Bookie> createBookieBet(Bookie bet) async {
    return await dataProvider.createBookieBet(bet);
  }

  Future<List<Bookie>> getBookieBets() async {
    return await dataProvider.getBookieBets();
  }

  Future<List<Bookie>> getGameBets(int gameID) async {
    return await dataProvider.getBookieBetsByGame(gameID);
  }

  Future<void> updateBookieBet(Bookie bet) async {
    await dataProvider.updateBookieBet(bet);
  }

  Future<void> deleteBookieBet(String id) async {
    await dataProvider.deleteBookieBet(id);
  }
}
