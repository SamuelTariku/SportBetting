import 'package:equatable/equatable.dart';
import '../models/fixture.dart';

abstract class FixtureEvent extends Equatable {
  const FixtureEvent();
}

class FixtureLoad extends FixtureEvent {
  const FixtureLoad();

  @override
  List<Object> get props => [];
}

class FixtureCreate extends FixtureEvent {
  final Fixture fix;

  const FixtureCreate(this.fix);

  @override
  List<Object> get props => [fix];

  @override
  String toString() => 'Fixture Created {fixture: $fix}';
}

class FixtureUpdate extends FixtureEvent {
  final Fixture fix;

  const FixtureUpdate(this.fix);

  @override
  List<Object> get props => [fix];

  @override
  String toString() => 'fixture Updated {fixture: $fix}';
}

class FixtureDelete extends FixtureEvent {
  final Fixture fix;

  const FixtureDelete(this.fix);

  @override
  List<Object> get props => [fix];

  @override
  toString() => 'Fixture Deleted {fixture: $fix}';
}
