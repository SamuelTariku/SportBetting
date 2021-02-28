import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_network/bet/bet.dart';

class AddUpdateBet extends StatefulWidget {
  static const routeName = 'betAddUpdate';
  final BetArgument args;

  AddUpdateBet({this.args});
  @override
  _AddUpdateBetState createState() => _AddUpdateBetState();
}

class _AddUpdateBetState extends State<AddUpdateBet> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _bet = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.args.edit ? "Edit Bet" : "Add New Bet"}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                  initialValue:
                      widget.args.edit ? widget.args.bet.bookieID : '',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter bet bookieid';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'bookieid'),
                  onSaved: (value) {
                    setState(() {
                      this._bet["bookieid"] = value;
                    });
                  }),
              TextFormField(
                  initialValue: widget.args.edit ? widget.args.bet.userID : '',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter bet userID';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'Bet userID'),
                  onSaved: (value) {
                    this._bet["userid"] = value;
                  }),
              TextFormField(
                  initialValue: widget.args.edit
                      ? widget.args.bet.outcome.toString()
                      : '',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter bet outcome';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'Bet outcome'),
                  onSaved: (value) {
                    setState(() {
                      this._bet["outcome"] = int.parse(value);
                    });
                  }),
              TextFormField(
                  initialValue:
                      widget.args.edit ? widget.args.bet.amount.toString() : '',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter bet amount';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'Bet Amount'),
                  onSaved: (value) {
                    setState(() {
                      this._bet["amount"] = value;
                    });
                  }),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    final form = _formKey.currentState;
                    if (form.validate()) {
                      form.save();
                      final BetEvent event = widget.args.edit
                          ? BetUpdate(
                              Bet(
                                id: widget.args.bet.id,
                                bookieID: this._bet["bookieid"],
                                userID: this._bet["userid"],
                                outcome: this._bet["outcome"],
                                amount: double.parse(this._bet["amount"]),
                              ),
                            )
                          : BetCreate(
                              Bet(
                                bookieID: this._bet["bookieid"],
                                userID: this._bet["userid"],
                                outcome: this._bet["outcome"],
                                amount: double.parse(this._bet["amount"]),
                              ),
                            );
                      BlocProvider.of<BetBloc>(context).add(event);
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          BetsList.routeName, (route) => false);
                    }
                  },
                  label: Text('ADD'),
                  icon: Icon(Icons.add),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
