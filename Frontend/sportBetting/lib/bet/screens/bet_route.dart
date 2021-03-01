import 'package:flutter/material.dart';
import 'package:flutter_network/bet/bet.dart';
import 'package:flutter_network/bet/screens/account.dart';
import 'package:flutter_network/bet/screens/game_bets.dart';
import 'package:flutter_network/bet/screens/login_attempt.dart';

class BetAppRoute {
  static Route generateRoute(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) => SignInScreen());
    }

    if (settings.name == SignUpScreen.routeName) {
      return MaterialPageRoute(builder: (context) => SignUpScreen());
    }

    if (settings.name == LoginAttempt.routeName) {
      return MaterialPageRoute(builder: (context) => LoginAttempt());
    }

    if (settings.name == GamesList.routeName) {
      return MaterialPageRoute(builder: (context) => GamesList());
    }

    if (settings.name == GameBetsList.routeName) {
      GameArgument args = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => GameBetsList(
                args: args,
              ));
    }

    if (settings.name == MakeBet.routeName) {
      MakeBetArgument args = settings.arguments;
      return MaterialPageRoute(builder: (context) => MakeBet(args: args));
    }

    if (settings.name == BetsList.routeName) {
      return MaterialPageRoute(builder: (context) => BetsList());
    }
    if (settings.name == AddUpdateBet.routeName) {
      BetArgument args = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => AddUpdateBet(
                args: args,
              ));
    }

    if (settings.name == BetDetail.routeName) {
      Bet bet = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => BetDetail(
                bet: bet,
              ));
    }

    if (settings.name == UserProfileScreen.routeName) {
      return MaterialPageRoute(builder: (context) => UserProfileScreen());
    }

    return MaterialPageRoute(builder: (context) => BetsList());
  }
}

class BetArgument {
  final Bet bet;
  final bool edit;
  BetArgument({this.bet, this.edit});
}

class GameArgument {
  final int gameID;
  GameArgument(this.gameID);
}

class MakeBetArgument {
  final String bookieID;
  final int outcome;

  MakeBetArgument(this.bookieID, this.outcome);
}
