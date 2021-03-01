import 'package:equatable/equatable.dart';
import 'package:flutter_network/bet/bet.dart';

abstract class BetEvent extends Equatable {
  const BetEvent();
}

class BetInitialize extends BetEvent {
  const BetInitialize();

  @override
  List<Object> get props => [];
}

class BetLoad extends BetEvent {
  final String userID;

  const BetLoad(this.userID);

  @override
  List<Object> get props => [userID];
}

class BetCreate extends BetEvent {
  final Bet bet;

  const BetCreate(this.bet);

  @override
  List<Object> get props => [bet];

  @override
  String toString() => 'Bet Created {bet: $bet}';
}

class BetUpdate extends BetEvent {
  final Bet bet;

  const BetUpdate(this.bet);

  @override
  List<Object> get props => [bet];

  @override
  String toString() => 'Bet Updated {bet: $bet}';
}

class BetDelete extends BetEvent {
  final Bet bet;

  const BetDelete(this.bet);

  @override
  List<Object> get props => [bet];

  @override
  toString() => 'Bet Deleted {bet: $bet}';
}
