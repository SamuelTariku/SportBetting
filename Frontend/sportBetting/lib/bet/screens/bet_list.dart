import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_network/bet/bloc/bloc.dart';
import 'package:flutter_network/bet/bet.dart';

class BetsList extends StatelessWidget {
  static const routeName = '/myBets';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('List of Bets'),
      ),
      body: BlocBuilder<BetBloc, BetState>(
        builder: (_, betState) {
          if (betState is BetOperationFailure) {
            return Text('Could not do bet operation');
          }

          if (betState is BetsLoadSuccess) {
            final bets = betState.bets;

            return BlocBuilder<BookieBloc, BookieState>(
              builder: (_, bookieState) {
                if (bookieState is BookieLoadSuccess) {
                  final bookieBets = bookieState.bets;
                  print("--------------BET BOOKIE BLOC------------------");
                  print(bookieBets);
                  print(bets);
                  return ListView.builder(
                      itemCount: bets.length,
                      itemBuilder: (_, idx) {
                        for (Bookie bookieBet in bookieBets) {
                          print(
                              "BOOKIE: ${bookieBet.id}, Bet: ${bets[idx].bookieID}");
                          if (int.parse(bookieBet.id) ==
                              int.parse(bets[idx].bookieID)) {
                            print(
                                "Outcome: ${bookieBet.outcomes[bets[idx].outcome].outcome}, ${bets[idx].amount} birr");
                            return ListTile(
                                title: Text(
                                    "${bookieBet.outcomes[bets[idx].outcome].outcome} ==> ${bets[idx].amount} birr"),
                                subtitle: Text("${bookieBet.datetime}"),
                                onTap: () => Navigator.of(context).pushNamed(
                                    BetDetail.routeName,
                                    arguments: bets[idx]));
                          }
                        }
                      });
                }
                return ListView.builder(
                  itemCount: bets.length,
                  itemBuilder: (_, idx) => ListTile(
                    title: Text('${bets[idx].amount}'),
                    subtitle: Text('${bets[idx].outcome}'),
                    onTap: () => Navigator.of(context)
                        .pushNamed(BetDetail.routeName, arguments: bets[idx]),
                  ),
                );
              },
            );
          }

          return CircularProgressIndicator();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .pushNamedAndRemoveUntil(GamesList.routeName, (_) => false),
        child: Icon(Icons.games),
      ),
    );
  }
}
