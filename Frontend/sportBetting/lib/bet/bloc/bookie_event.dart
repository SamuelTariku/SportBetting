import 'package:equatable/equatable.dart';
import '../bet.dart';

abstract class BookieBetEvent extends Equatable {
  const BookieBetEvent();
}

class BookieBetLoad extends BookieBetEvent {
  const BookieBetLoad();

  @override
  List<Object> get props => [];
}

class BookieBetCreate extends BookieBetEvent {
  final Bookie bets;

  const BookieBetCreate(this.bets);

  @override
  List<Object> get props => [bets];

  @override
  String toString() => 'Bookie Bet Created {bet: $bets}';
}

class BookieBetUpdate extends BookieBetEvent {
  final Bookie bet;

  const BookieBetUpdate(this.bet);

  @override
  List<Object> get props => [bet];

  @override
  String toString() => 'Bookie Bet Updated {bet: $bet}';
}

class BookieBetDelete extends BookieBetEvent {
  final Bookie bet;

  const BookieBetDelete(this.bet);

  @override
  List<Object> get props => [bet];

  @override
  toString() => 'Bookie Bet Deleted {bet: $bet}';
}
