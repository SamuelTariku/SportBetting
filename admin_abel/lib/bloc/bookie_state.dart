import 'package:admin_abel/models/bookie.dart';
import 'package:equatable/equatable.dart';

class BookieState extends Equatable {
  const BookieState();

  @override
  List<Object> get props => [];
}

class BookieLoading extends BookieState {}

class BookieLoadSuccess extends BookieState {
  final List<Bookie> bets;

  BookieLoadSuccess([this.bets = const []]);

  @override
  List<Object> get props => [bets];
}

class BookieOperationFailure extends BookieState {}