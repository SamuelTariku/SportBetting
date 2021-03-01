import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../models/fixture.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/fixture_repository.dart';
import 'fixture_event.dart';
import 'fixture_state.dart';

class FixtureBloc extends Bloc<FixtureEvent, FixtureState> {
  final FixtureRepository fixtureRepository;

  FixtureBloc({@required this.fixtureRepository})
      : assert(fixtureRepository != null),
        super(FixtureLoading());

  @override
  Stream<FixtureState> mapEventToState(FixtureEvent event) async* {
    if (event is FixtureLoad) {
      yield FixtureLoading();
      try {
        final fix = await fixtureRepository.getFixture();
        yield FixtureLoadSuccess(fix);
      } catch (e) {
       // print('catch error');
       print(e);
        yield FixtureOperationFailure();
      }
    }

    if (event is FixtureCreate) {
      try {
        await fixtureRepository.createFixture(event.fix);
        final courses = await fixtureRepository.getFixture();
        yield FixtureLoadSuccess(courses);
      } catch (_) {
        yield FixtureOperationFailure();
      }
    }

    if (event is FixtureUpdate) {
      try {
        await fixtureRepository.updateFixture(event.fix);
        final courses = await fixtureRepository.getFixture();
        yield FixtureLoadSuccess(courses);
      } catch (_) {
        yield FixtureOperationFailure();
      }
    }

    if (event is FixtureDelete) {
      try {
        await fixtureRepository.deleteFixture(event.fix.id);
        final courses = await fixtureRepository.getFixture();
        yield FixtureLoadSuccess(courses);
      } catch (_) {
        yield FixtureOperationFailure();
      }
    }
  }
}
