import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'outcome.dart';

@immutable
class Bookie extends Equatable {
  Bookie(
      {this.id,
        this.gameID,
        this.datetime,
        this.betName,
        this.betDesc,
        this.outcomes,
        this.outcome});

  final String id;
  final String gameID;
  final String datetime;
  final String betName;
  final String betDesc;
   List<Outcome> outcomes;
   int outcome;

  @override
  List<Object> get props =>
      [id, gameID, datetime, betName, betDesc, outcomes, outcome];

  factory Bookie.fromJson(Map<String, dynamic> json) {
    print(json);
    return Bookie(
        id: json['id'],
        gameID: json['game_id'],
        datetime: json['datetime'],
        betName: json['bettype']['bet_name'],
        betDesc: json['bettype']['bet_desc'],
        outcomes: List<Outcome>.from(
            json['outcomes'].map((out) => Outcome.fromJson(out)).toList()),
        outcome: json['outcome']);
  }

  @override
  String toString() =>
      'Bookie { id: $id, game_id: $gameID, datetime: $datetime, betName: $betName, betDesc: $betDesc, outcome: $outcome}';
}