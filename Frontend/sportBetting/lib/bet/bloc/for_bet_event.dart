import 'package:equatable/equatable.dart';
import '../bet.dart';

abstract class ForBetEvent extends Equatable {
  const ForBetEvent();
}

class ForBetLoad extends ForBetEvent {
  const ForBetLoad(); 

  @override
  List<Object> get props => [];
}

class ForBetCreate extends ForBetEvent {
  final ForBet bets;

  const ForBetCreate(this.bets);

  @override
  List<Object> get props => [bets];

  @override
  String toString() => 'Bet Created {bet: $bets}';
}

class ForBetUpdate extends ForBetEvent {
  final ForBet bet;

  const ForBetUpdate(this.bet);

  @override
  List<Object> get props => [bet];

  @override
  String toString() => 'Bet Updated {bet: $bet}';
}

class ForBetDelete extends ForBetEvent {
  final ForBet bet;

  const ForBetDelete(this.bet);

  @override
  List<Object> get props => [bet];

  @override
  toString() => 'Bet Deleted {bet: $bet}';
}
