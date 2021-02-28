import 'package:equatable/equatable.dart';
import 'package:flutter_network/bet/bet.dart';

class BetState extends Equatable {
  const BetState();

  @override
  List<Object> get props => [];
}

class BetLoading extends BetState {}

class BetsLoadSuccess extends BetState {
  final List<Bet> bets;

  BetsLoadSuccess([this.bets = const []]);

  @override
  List<Object> get props => [bets];
}

class BetOperationFailure extends BetState {}
