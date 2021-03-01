import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Bet extends Equatable {
  Bet(
      {this.id,
        @required this.userID,
        @required this.bookieID,
        @required this.amount,
        this.outcome});

  final String id;
  final String userID;
  final String bookieID;
  final double amount;
  final int outcome;

  @override
  List<Object> get props => [id, userID, bookieID, amount, outcome];

  factory Bet.fromJson(Map<String, dynamic> json) {
    // print(Bet(
    //   id: '89a0736bbd894e4faee9d783c2389e8e',
    //   userID: '2915d296-5526-498d-a691-ea4e1c0fd847',
    //   bookieID: "89a0736bbd894e4faee9d783c4789e8e",
    //   amount: 200.0,
    //   outcome: json['outcome'],
    // ));

    return Bet(
      id: json['id'],
      userID: json['userid'],
      bookieID: json['bookieid'],
      amount: json['amount'],
      outcome: json['outcome'],
    );
  }

  @override
  String toString() =>
      'Bet { id: $id, bookieid: $bookieID, outcome: $outcome, amount: $amount, userid: $userID }';
}