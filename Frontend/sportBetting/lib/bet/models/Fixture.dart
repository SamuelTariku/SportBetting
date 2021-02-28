import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Fixture extends Equatable {
  Fixture(
      {this.id, @required this.teamOne, @required this.teamTwo, this.datetime});

  final int id;
  final String teamOne;
  final String teamTwo;
  final String datetime;

  @override
  List<Object> get props => [id, teamOne, teamTwo, datetime];

  factory Fixture.fromJson(Map<String, dynamic> json) {
    return Fixture(
      id: json['id'],
      teamOne: json['team_one'],
      teamTwo: json['team_two'],
      datetime: json['datetime'],
    );
  }

  @override
  String toString() =>
      'Fixture { id: $id, team_one: $teamOne, team_two: $teamTwo, datetime: $datetime}';
}
