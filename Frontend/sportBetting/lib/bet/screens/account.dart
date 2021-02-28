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
        body: Form(
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
                      final BetEvent event = BetCreate(Bet(
                          amount: this.amount,
                          bookieID: this.args.bookieID,
                          outcome: this.args.outcome,
                          userID: "2915d296-5526-498d-a691-ea4e1c0fd847"));
                      print(this.args.outcome);
                      BlocProvider.of<BetBloc>(context).add(event);
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          GamesList.routeName, (route) => false);
                    }
                  },
                  child: Text("Submit"))
            ],
          ),
        ));
  }
}
