import 'package:equatable/equatable.dart';
import 'package:flutter_network/bet/bet.dart';

abstract class FixtureEvent extends Equatable {
  const FixtureEvent();
}

class FixtureLoad extends FixtureEvent {
  const FixtureLoad();

  @override
  List<Object> get props => [];
}

class FixtureCreate extends FixtureEvent {
  final Fixture game;

  const FixtureCreate(this.game);

  @override
  List<Object> get props => [game];

  @override
  String toString() => 'Game Created {game: $game}';
}

class FixtureUpdate extends FixtureEvent {
  final Fixture game;

  const FixtureUpdate(this.game);

  @override
  List<Object> get props => [game];

  @override
  String toString() => 'Game Updated {game: $game}';
}

class FixtureDelete extends FixtureEvent {
  final Fixture game;

  const FixtureDelete(this.game);

  @override
  List<Object> get props => [game];

  @override
  toString() => 'Game Deleted {game: $game}';
}
