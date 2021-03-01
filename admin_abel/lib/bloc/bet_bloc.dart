import 'package:admin_abel/repository/bet_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'bet_event.dart';
import 'bet_state.dart';

class BetBloc extends Bloc<BetEvent, BetState> {
  final BetRepository betRepository;

  BetBloc({@required this.betRepository})
      : assert(betRepository != null),
        super(BetLoading());

  @override
  Stream<BetState> mapEventToState(BetEvent event) async* {
    if (event is BetLoad) {
      yield BetLoading();
      try {
        final bets = await betRepository.getBets();
        print(bets);
        yield BetsLoadSuccess(bets);
      } catch (e) {
        print("Exception: $e");
        yield BetOperationFailure();
      }
    }

    if (event is BetCreate) {
      try {
        await betRepository.createBet(event.bet);
        final bets = await betRepository.getBets();
        yield BetsLoadSuccess(bets);
      } catch (e) {
        print("Exception: $e");
        yield BetOperationFailure();
      }
    }

    if (event is BetUpdate) {
      try {
        await betRepository.updateBet(event.bet);
        final bets = await betRepository.getBets();
        yield BetsLoadSuccess(bets);
      } catch (e) {
        print("Excpetion: $e");
        yield BetOperationFailure();
      }
    }

    if (event is BetDelete) {
      try {
        await betRepository.deleteBet(event.bet.id);
        final bets = await betRepository.getBets();
        yield BetsLoadSuccess(bets);
      } catch (e) {
        print("Excpetion: $e");
        yield BetOperationFailure();
      }
    }
  }
}