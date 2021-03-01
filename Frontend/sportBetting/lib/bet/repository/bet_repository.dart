import 'package:meta/meta.dart';
import 'package:flutter_network/bet/bet.dart';

class BetRepository {
  final BetDataProvider dataProvider;

  BetRepository({@required this.dataProvider}) : assert(dataProvider != null);

  Future<Bet> createBet(Bet bet) async {
    return await dataProvider.createBet(bet);
  }

  Future<List<Bet>> getBets(String userID) async {
    return await dataProvider.getBets(userID);
  }

  Future<void> updateBet(Bet bet) async {
    await dataProvider.updateBet(bet);
  }

  Future<void> deleteBet(String id) async {
    await dataProvider.deleteBets(id);
  }
}
