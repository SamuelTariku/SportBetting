import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Fixture extends Equatable {
  Fixture(
      {this.id,
        @required this.teamOne,
        @required this.teamTwo,
        @required this.time,
        @required this.homeOdd,
        @required this.awayOdd,
        @required this.drawOdd,
        @required this.firstTeamOdd,
        @required this.secondTeamOdd
      });

  final String id;
  final String teamOne;
  final String teamTwo;
  final String time;
  final int homeOdd;
  final int awayOdd;
  final int drawOdd;
  final int firstTeamOdd;
  final int secondTeamOdd;


  @override
  List<Object> get props => [id, teamOne, teamTwo, time,homeOdd,awayOdd,drawOdd,firstTeamOdd,secondTeamOdd];

  factory Fixture.fromJson(Map<String, dynamic> json) {
    return Fixture(
      id: json['id'].toString(),
      teamOne: json['team_one'],
      teamTwo: json['team_two'],
      time: json['datetime'],
      homeOdd: json['team_one_odd'],
      awayOdd: json['team_two_odd'],
      drawOdd: json['draw_odd'],
      firstTeamOdd: json['team_one_score_first_odd'],
      secondTeamOdd: json['team_two_score_first_odd'],
    );
  }

  @override
  String toString() => 'Fixture { id: $id, team_one: $teamOne, team_two: $teamTwo, datetime: $time,team_one_odd:$homeOdd,team_two_odd: $awayOdd,draw_odd: $drawOdd,team_one_score_first_odd:$firstTeamOdd,team_two_score_first_odd:$secondTeamOdd}';
}