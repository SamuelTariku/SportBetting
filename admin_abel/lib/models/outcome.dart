import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Outcome extends Equatable {
  Outcome({this.index, @required this.odd, @required this.outcome});

  final int index;
  final double odd;
  final String outcome;

  @override
  List<Object> get props => [index, odd, outcome];

  factory Outcome.fromJson(Map<String, dynamic> json) {
    return Outcome(
      index: json['index'],
      odd: json['odd'],
      outcome: json['outcome'],
    );
  }

  @override
  String toString() => 'Outcome { index: $index, odd: $odd, outcome: $outcome}';
}