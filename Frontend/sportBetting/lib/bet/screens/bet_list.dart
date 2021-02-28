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
        title: Text('List of Bets'),
      ),
      body: BlocBuilder<BetBloc, BetState>(
        builder: (_, state) {
          if (state is BetOperationFailure) {
            return Text('Could not do bet operation');
          }

          if (state is BetsLoadSuccess) {
            final bets = state.bets;

            return ListView.builder(
              itemCount: bets.length,
              itemBuilder: (_, idx) => ListTile(
                title: Text('${bets[idx].amount}'),
                subtitle: Text('${bets[idx].outcome}'),
                onTap: () => Navigator.of(context)
                    .pushNamed(BetDetail.routeName, arguments: bets[idx]),
              ),
            );
          }

          return CircularProgressIndicator();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(
          GamesList.routeName,
        ),
        child: Icon(Icons.games),
      ),
    );
  }
}
