import 'package:admin_abel/models/bet.dart';
import 'package:equatable/equatable.dart';

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