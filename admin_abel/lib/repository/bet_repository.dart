import 'package:admin_abel/data_provider/bet_data.dart';
import 'package:admin_abel/models/bet.dart';
import 'package:meta/meta.dart';

class BetRepository {
  final BetDataProvider dataProvider;

  BetRepository({@required this.dataProvider})
      : assert(dataProvider != null);

  Future<Bet> createBet(Bet bet) async {
    return await dataProvider.createBet(bet);
  }

  Future<List<Bet>> getBets() async {
    return await dataProvider.getBets();
  }

  Future<void> updateBet(Bet bet) async {
    await dataProvider.updateBet(bet);
  }

  Future<void> deleteBet(String id) async {
    await dataProvider.deleteBets(id);
  }
}