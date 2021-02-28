import 'package:meta/meta.dart';
import '../bet.dart';

class ForBetRepository {
  final ForBetRepository dataProvider;

  ForBetRepository({@required this.dataProvider})
      : assert(dataProvider != null);

  Future<ForBet> createBet(ForBet bet) async {
    return await dataProvider.createBet(bet);
  }

  Future<List<ForBet>> getBets() async {
    return await dataProvider.getBets();
  }

  Future<void> updateBet(ForBet bet) async {
    await dataProvider.updateBet(bet);
  }

  Future<void> deleteBets(int id) async {
    await dataProvider.deleteBets(id);
  }
}
