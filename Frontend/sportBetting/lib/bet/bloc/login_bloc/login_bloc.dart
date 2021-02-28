import '../authentication_bloc/authentication_bloc.dart';
import '../authentication_bloc/authentication_event.dart';
import '../../repository/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationBloc _authenticationBloc;
  final AuthenticationRepository _authenticationRepository;

  LoginBloc(AuthenticationBloc authenticationBloc, AuthenticationRepository authentication_authenticationRepository)
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

  Stream<LoginState> _mapLoginWithEmailToState(LoginInWithEmailButtonPressed event) async* {
    yield LoginLoading();
    print('Nth very weird just happened');
    try {
      final token = await _authenticationRepository.signInWithEmailAndPassword(event.user);
      print(token);
      final user = await _authenticationRepository.getUser(int.parse(token));
      if (user != null) {
        print('userEmail');
        print(user.email);
        _authenticationBloc.add(UserLoggedIn(user: user));
        yield LoginSuccess();
        yield LoginInitial();
      } else {
        yield LoginFailure(error: 'Something very weird just happened');
      }
    } on Exception catch (e) {
      yield LoginFailure(error: "");
    } catch (err) {
      yield LoginFailure(error: err.message ?? 'An unknown error occured');
    }
  }
}