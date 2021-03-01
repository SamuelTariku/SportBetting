import 'package:admin_abel/repository/bookie_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bookie_event.dart';
import 'bookie_state.dart';

class BookieBloc extends Bloc<BookieBetEvent, BookieState> {
  final BookieRepository bookieRepository;

  BookieBloc({@required this.bookieRepository})
      : assert(bookieRepository != null),
        super(BookieLoading());

  @override
  Stream<BookieState> mapEventToState(BookieBetEvent event) async* {
    if (event is BookieBetLoad) {
      yield BookieLoading();
      try {
        final bets = await bookieRepository.getBookieBets();
        print(bets);
        yield BookieLoadSuccess(bets);
      } catch (e) {
        print("Exception: $e");
        yield BookieOperationFailure();
      }
    }

    if (event is BookieBetCreate) {
      try {
        await bookieRepository.createBookieBet(event.bets);
        final bets = await bookieRepository.getBookieBets();
        yield BookieLoadSuccess(bets);
      } catch (_) {
        yield BookieOperationFailure();
      }
    }

    if (event is BookieBetUpdate) {
      try {

        await bookieRepository.updateBookieBet(event.bet);
        final bets = await bookieRepository.getBookieBets();
       // print(bets);
        yield BookieLoadSuccess(bets);
      } catch (e) {
        print('errroeoe');
        yield BookieOperationFailure();
      }
    }

    if (event is BookieBetDelete) {
      try {
        await bookieRepository.deleteBookieBet(event.bet.id);
        final bets = await bookieRepository.getBookieBets();
        yield BookieLoadSuccess(bets);
      } catch (_) {
        yield BookieOperationFailure();
      }
    }
  }
}