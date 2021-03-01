import '../authentication_bloc/authentication_bloc.dart';
import '../authentication_bloc/authentication_event.dart';
import '../../repository/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationBloc _authenticationBloc;
  final AuthenticationRepository _authenticationRepository;

  LoginBloc(AuthenticationBloc authenticationBloc,
      AuthenticationRepository authentication_authenticationRepository)
      : assert(authenticationBloc != null),
        assert(authentication_authenticationRepository != null),
        _authenticationBloc = authenticationBloc,
        _authenticationRepository = authentication_authenticationRepository,
        super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginInWithEmailButtonPressed) {
      yield* _mapLoginWithEmailToState(event);
    }
  }

  Stream<LoginState> _mapLoginWithEmailToState(
      LoginInWithEmailButtonPressed event) async* {
    yield LoginLoading();
    try {
      final payload = await _authenticationRepository
          .signInWithEmailAndPassword(event.user);
      print(payload);
      final user = await _authenticationRepository.getUser(
          payload['public_id'], payload['token']);
      print(user);
      if (user != null) {
        print('user');
        print(user.username);
        _authenticationBloc.add(UserLoggedIn(user: user));
        yield LoginSuccess(user: user);
      } else {
        yield LoginFailure(error: 'Unknown user');
      }
    } on Exception catch (e) {
      print("Exception: $e");
      yield LoginFailure(error: "");
    } catch (err) {
      print("Exception: $err");
      yield LoginFailure(error: err.message ?? 'An unknown error occured');
    }
  }
}
