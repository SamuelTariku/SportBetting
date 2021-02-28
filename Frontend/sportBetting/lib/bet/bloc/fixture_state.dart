import 'package:equatable/equatable.dart';
import 'package:flutter_network/bet/bet.dart';

class FixtureState extends Equatable {
  const FixtureState();

  @override
  List<Object> get props => [];
}

class FixtureLoading extends FixtureState {}

class FixtureLoadSuccess extends FixtureState {
  final List<Fixture> games;

  FixtureLoadSuccess([this.games = const []]);

  @override
  List<Object> get props => [games];
}

class FixtureOperationFailure extends FixtureState {}
