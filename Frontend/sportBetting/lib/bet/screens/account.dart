import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_network/bet/bloc/bloc.dart';
import 'package:flutter_network/bet/bet.dart';
import 'package:flutter_network/bet/screens/game_bets.dart';

class MakeBet extends StatelessWidget {
  static const routeName = '/account';
  final MakeBetArgument args;
  final _formKey = GlobalKey<FormState>();
  double amount;

  MakeBet({this.args});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('SportBetting'),
          actions: [
            FlatButton(
              textColor: Colors.white,
              onPressed: null,
              child: Text("My Bets"),
              shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
            )
          ],
        ),
        body: BlocBuilder<LoginBloc, LoginState>(builder: (_, state) {
          if (state is LoginSuccess) {
            final User user = state.user;

            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(""),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Amount",
                        hintText: "How much do you want to bet"),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter amount';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      this.amount = double.parse(value);
                    },
                  ),
                  ElevatedButton(
                      onPressed: () {
                        final form = _formKey.currentState;
                        if (form.validate()) {
                          form.save();
                          print("HERERER:" + this.args.toString());
                          final BetEvent event = BetCreate(Bet(
                              amount: this.amount,
                              bookieID: this.args.bookieID,
                              outcome: this.args.outcome,
                              userID: user.id));
                          print(this.args.outcome);
                          BlocProvider.of<BetBloc>(context).add(event);
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              GamesList.routeName, (route) => false);
                        }
                      },
                      child: Text("Submit"))
                ],
              ),
            );
          }
          return Center(
              child: Column(
            children: [
              Text("YOU NEED TO SIGN IN"),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        SignInScreen.routeName, (route) => false);
                  },
                  child: Text("Back to sign in"))
            ],
          ));
        }));
  }
}
