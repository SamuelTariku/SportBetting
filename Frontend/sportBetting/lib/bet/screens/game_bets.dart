import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_network/bet/bloc/bloc.dart';
import 'package:flutter_network/bet/bet.dart';

class GameBetsList extends StatelessWidget {
  static const routeName = '/game_bets';
  final GameArgument args;

  GameBetsList({this.args});
  //final Map<String, dynamic> _bet = {};

  @override
  Widget build(BuildContext context) {
    // final BookieBetEvent event = BookieBetLoad(widget.args.gameID);
    // //BlocProvider.of<BookieBloc>(context).add(event);
    print(this.args.gameID);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Bets for game'),
      ),
      body: BlocBuilder<BookieBloc, BookieState>(
        builder: (ctx, state) {
          if (state is BookieOperationFailure) {
            return Text('Could not do bet operation');
          }

          if (state is BookieLoadSuccess) {
            final bets = state.bets;

            return ListView.builder(
              itemCount: bets.length,
              itemBuilder: (_, idx) {
                print("${this.args.gameID} and ${bets[idx].gameID}");
                if (this.args.gameID != int.parse(bets[idx].gameID)) {
                  return Container();
                }
                return Card(
                    child: Column(children: [
                  Container(
                      width: double.infinity,
                      height: 50,
                      color: Colors.grey,
                      child: Center(child: Text(bets[idx].betName))),
                  Container(
                      height: 200.0,
                      child: ListView.builder(
                          itemCount: bets[idx].outcomes.length,
                          itemBuilder: (_, secondIndex) => ListTile(
                                title: Text(
                                    '${bets[idx].outcomes[secondIndex].outcome}'),
                                subtitle: Text(
                                    '${bets[idx].outcomes[secondIndex].odd}'),
                                onTap: () => Navigator.of(context).pushNamed(
                                    MakeBet.routeName,
                                    arguments: MakeBetArgument(
                                        bets[idx].id, secondIndex)),
                              )))
                ]));
              },
            );
          }

          return CircularProgressIndicator();
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => Navigator.of(context).pushNamed(
      //     AddUpdateBet.routeName,
      //     arguments: BetArgument(edit: false),
      //   ),
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
