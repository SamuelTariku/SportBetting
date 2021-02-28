import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repository/user_repository.dart';
import '../../models/user.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent,UserState>{
  final UserRepository userRepository;
  UserBloc({@required this.userRepository}):assert(userRepository!=null), super(UserInProgress());
  @override
  Stream<UserState> mapEventToState(UserEvent event) async*{

    if(event is UserCreate){
      print('fired user create');

      try {
        await userRepository.createUser(event.user);
        //final comments = await commentRepository.getComments(event.comment.recipeid);
        yield UserSuccessfull();
      } catch (_) {
        yield UserFailure();
      }

    }

    if (event is UserDelete) {
      // try {
      //   int rid = event.comment.recipeid;
      //   await commentRepository.deleteComment(event.comment.id);
      //   final comments = await commentRepository.getComments(rid);
      //   yield CommentSuccessfull(comments);
      // } catch (_) {
      //   yield CommentFailure();
      // }
    }
    if(event is UserUpdate){
      //  int rid = event.comment.recipeid;
      //   print(rid);
      //   try {
      //   await commentRepository.updateComment(event.comment);
      //  final comments = await commentRepository.getComments(rid);
      //  print('fefefefefefefefefefeefe');
      //   yield CommentSuccessfull(comments);
      //   print('commne sucesssssss');
      // } catch (_) {
      //   yield CommentFailure();
      // }
    }


  }

} 