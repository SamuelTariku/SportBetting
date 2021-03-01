import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_network/bet/bet.dart';

class BetDetail extends StatelessWidget {
  static const routeName = 'betDetail';
  final Bet bet;

  BetDetail({@required this.bet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('${this.bet.bookieID}'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => Navigator.of(context).pushNamed(
              AddUpdateBet.routeName,
              arguments: BetArgument(bet: this.bet, edit: true),
            ),
          ),
          SizedBox(
            width: 32,
          ),
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                context.read<BetBloc>().add(BetDelete(this.bet));
                Navigator.of(context).pushNamedAndRemoveUntil(
                    BetsList.routeName, (route) => false);
              }),
        ],
      ),
      body: Card(
        child: Column(
          children: [
            ListTile(
              title: Text('UserID: ${this.bet.userID}'),
              subtitle: Text('Outcome: ${this.bet.outcome}'),
            ),
            Text(
              'Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(this.bet.amount.toString()),
          ],
        ),
      ),
    );
  }
}
