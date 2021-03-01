import 'package:admin_abel/models/bet.dart';
import 'package:equatable/equatable.dart';

abstract class BetEvent extends Equatable {
  const BetEvent();
}

class BetLoad extends BetEvent {
  const BetLoad();

  @override
  List<Object> get props => [];
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