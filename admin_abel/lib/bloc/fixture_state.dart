import 'package:equatable/equatable.dart';
import '../models/fixture.dart';

class FixtureState extends Equatable {
  const FixtureState();

  @override
  List<Object> get props => [];
}

class FixtureLoading extends FixtureState {}

class FixtureLoadSuccess extends FixtureState {
  final List<Fixture> fix;

  FixtureLoadSuccess([this.fix = const []]);

  @override
  List<Object> get props => [fix];
}

class FixtureOperationFailure extends FixtureState {}