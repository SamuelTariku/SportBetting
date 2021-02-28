import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class ForBet extends Equatable {
  ForBet(
      {this.id,
        this.userID,
        @required this.balance,
        @required this.amount,
        @required this.outcome,
        this.winStatus});

  final int id;
  final int userID;
  final double balance;
  final double amount;
  final double outcome;
  final bool winStatus;

  @override
  List<Object> get props => [id, userID, balance, amount, outcome, winStatus];

  factory ForBet.fromJson(Map<String, dynamic> json) {

    return ForBet(
      id: json['id'],
      userID: json['userid'],
      balance: json['balance'],
      amount: json['amount'],
      outcome: json['outcome'],
      winStatus: json['winstatus']
    );
  }

  @override
  String toString() => 'Bet { id: $id, bookieid: $balance, outcome: $outcome, amount: $amount, userid: $userID, winstatus: $winStatus }';
}
