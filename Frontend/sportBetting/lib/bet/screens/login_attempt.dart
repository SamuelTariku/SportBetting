import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_network/bet/bloc/bloc.dart';
import 'package:flutter_network/bet/bet.dart';

class LoginAttempt extends StatelessWidget {
  static const routeName = '/loginAttempt';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<LoginBloc, LoginState>(builder: (_, state) {
      print("---------------------------");
      print(state);
      print("----------------------------");

      if (state is LoginSuccess) {
        BlocProvider.of<BetBloc>(context)..add(BetLoad(state.user.id));
        Future.delayed(Duration(seconds: 1), () {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(GamesList.routeName, (_) => false);
        });
      }

      if (state is LoginFailure) {
        return Center(
            child: Column(children: [
          Icon(Icons.error),
          Text("There seems to be an error"),
          ElevatedButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(SignInScreen.routeName),
              child: Text("Back")),
          ElevatedButton(
              onPressed: () => print(state), child: Text("print-state"))
        ]));
      }

      if (state is LoginInitial) {
        return Text("Initilized State");
      }

      return Center(child: Image.asset('images/running.gif'));
    }));
  }
}
