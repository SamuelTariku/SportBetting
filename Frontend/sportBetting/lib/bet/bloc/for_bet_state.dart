import 'package:equatable/equatable.dart';
import '../bet.dart';

class ForBetState extends Equatable {
  const ForBetState();

  @override
  List<Object> get props => [];
}

class ForBetLoading extends ForBetState {}

class ForBetsLoadSuccess extends ForBetState {
  final List<ForBet> bets;

  ForBetsLoadSuccess([this.bets = const []]);

  @override
  List<Object> get props => [bets];
}

class ForBetOperationFailure extends ForBetState {}
