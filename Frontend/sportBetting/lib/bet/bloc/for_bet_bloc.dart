import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc.dart';
import '../bet.dart';

class ForBetBloc extends Bloc<ForBetEvent, ForBetState> {
  final ForBetRepository betRepository;

  ForBetBloc({@required this.betRepository})
      : assert(betRepository != null),
        super(ForBetLoading());

  @override
  Stream<ForBetState> mapEventToState(ForBetEvent event) async* {
    if (event is ForBetLoad) {
      yield ForBetLoading();
      try {
        final forbets = await betRepository.getBets();
        print(forbets);
        yield ForBetsLoadSuccess(forbets);
      } catch (_) {
        yield ForBetOperationFailure();
      }
    }

    if (event is ForBetCreate) {
      try {
        await betRepository.createBet(event.bets);
        final bets = await betRepository.getBets();
        yield ForBetsLoadSuccess(bets);
      } catch (_) {
        yield ForBetOperationFailure();
      }
    }

    if (event is ForBetUpdate) {
      try {
        await betRepository.updateBet(event.bet);
        final bets = await betRepository.getBets();
        yield ForBetsLoadSuccess(bets);
      } catch (_) {
        yield ForBetOperationFailure();
      }
    }

    if (event is ForBetDelete) {
      try {
        await betRepository.deleteBets(event.bet.id);
        final bets = await betRepository.getBets();
        yield ForBetsLoadSuccess(bets);
      } catch (_) {
        yield ForBetOperationFailure();
      }
    }
  }
}
