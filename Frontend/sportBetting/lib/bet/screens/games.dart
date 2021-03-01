import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_network/bet/bloc/bloc.dart';
import 'package:flutter_network/bet/bet.dart';
import 'package:flutter_network/bet/screens/game_bets.dart';
import 'package:flutter_network/bet/screens/user_profile_screen.dart';

class GamesList extends StatelessWidget {
  static const routeName = '/games';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('SportBetting'),
        actions: [
          FlatButton(
            textColor: Colors.white,
            onPressed: () =>
                Navigator.of(context).pushNamed(BetsList.routeName),
            child: Text("My Bets"),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
          FlatButton(
            textColor: Colors.white,
            onPressed: () =>
                Navigator.of(context).pushNamed(UserProfileScreen.routeName),
            child: Text("User Profile"),
          ),
          FlatButton(
            textColor: Colors.white,
            onPressed: () =>
                Navigator.of(context).pushNamed(SignInScreen.routeName),
            child: Text("Logout"),
          ),
        ],
      ),
      body: BlocBuilder<FixtureBloc, FixtureState>(
        builder: (_, state) {
          if (state is FixtureOperationFailure) {
            return Text('Could not get games');
          }

          if (state is FixtureLoadSuccess) {
            final games = state.games;

            return ListView.builder(
              itemCount: games.length,
              itemBuilder: (_, idx) => ListTile(
                title: Text('${games[idx].teamOne} vs ${games[idx].teamTwo}'),
                subtitle: Text("${games[idx].datetime}"),
                onTap: () => Navigator.of(context).pushNamed(
                    GameBetsList.routeName,
                    arguments: GameArgument(games[idx].id)),
              ),
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
