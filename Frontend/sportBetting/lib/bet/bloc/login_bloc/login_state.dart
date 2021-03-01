import '../../models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final User user;

  LoginSuccess({this.user});

  @override
  List<Object> get props => [user];
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure({@required this.error});

  @override
  List<Object> get props => [error];
}
