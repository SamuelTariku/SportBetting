import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_network/bet/bloc/bloc.dart';
import 'package:flutter_network/bet/bet.dart';

class FixtureBloc extends Bloc<FixtureEvent, FixtureState> {
  final FixtureRepository gameRepo;

  FixtureBloc({@required this.gameRepo})
      : assert(gameRepo != null),
        super(FixtureLoading());

  @override
  Stream<FixtureState> mapEventToState(FixtureEvent event) async* {
    if (event is FixtureLoad) {
      yield FixtureLoading();
      try {
        final games = await gameRepo.getGames();
        print(games);
        yield FixtureLoadSuccess(games);
      } catch (_) {
        yield FixtureOperationFailure();
      }
    }

    if (event is FixtureCreate) {
      try {
        await gameRepo.createGame(event.game);
        final bets = await gameRepo.getGames();
        yield FixtureLoadSuccess(bets);
      } catch (_) {
        yield FixtureOperationFailure();
      }
    }

    if (event is FixtureUpdate) {
      try {
        await gameRepo.updateGame(event.game);
        final game = await gameRepo.getGames();
        yield FixtureLoadSuccess(game);
      } catch (_) {
        yield FixtureOperationFailure();
      }
    }

    if (event is FixtureUpdate) {
      try {
        await gameRepo.deleteGames(event.game.id);
        final game = await gameRepo.getGames();
        yield FixtureLoadSuccess(game);
      } catch (_) {
        yield FixtureOperationFailure();
      }
    }
  }
}
