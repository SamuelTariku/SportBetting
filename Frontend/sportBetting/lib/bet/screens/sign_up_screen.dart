import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_network/bet/bloc/bloc.dart';
import 'package:flutter_network/bet/bet.dart';

class SignUpScreen extends StatefulWidget {
  static String routeName = '/signup';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  var user = User(username: '', password: '');

  void onSave(BuildContext context) {
    print("againnnnnnnnnnnnnnnnn");
    print(user.password);
    print(user.username);
    formkey.currentState.save();
    BlocProvider.of<UserBloc>(context).add(UserCreate(user));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: formkey,
        child: ListView(
          children: <Widget>[
            Container(
                child: BlocBuilder<UserBloc, UserState>(builder: (_, state) {
              if (state is UserSuccessfull) {
                Future.delayed(Duration(seconds: 1), () {
                  Navigator.pop(context);
                });
              }

              if (state is UserFailure) {
                return Text("There is an error");
              }

              if (state is UserInitial || state is UserInProgress) {
                return Text("");
              }

              return Center(child: CircularProgressIndicator());
            })),
            // BackButtonWidget(),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  IconButton(icon: Icon(Icons.person), onPressed: null),
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.only(right: 20, left: 10),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Username',
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green),
                              ),
                            ),
                            onSaved: (value) {
                              user.username = value;
                            },
                            validator: (String value) {
                              if (value.length < 5) {
                                return 'Username must be atleast 5 characters long';
                              }
                              return null;
                            },
                          )))
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: <Widget>[
                  IconButton(icon: Icon(Icons.lock), onPressed: null),
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.only(right: 20, left: 10),
                          child: TextFormField(
                            controller: _pass,
                            onSaved: (value) {
                              user.password = value;
                            },
                            decoration: InputDecoration(
                              hintText: 'Password',
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green),
                              ),
                            ),
                            validator: (String value) {
                              if (value.length < 5) {
                                return 'Password must be atleast 5 characters long';
                              }
                              return null;
                            },
                          )))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: <Widget>[
                  IconButton(icon: Icon(Icons.lock), onPressed: null),
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.only(right: 20, left: 10),
                          child: TextFormField(
                            controller: _confirmPass,
                            decoration: InputDecoration(
                              hintText: 'Confirm Password',
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green),
                              ),
                            ),
                            validator: (String value) {
                              if (value.length < 5) {
                                return 'Password must be atleast 5 characters long';
                              }
                              if (value != _pass.text) {
                                return 'Password must match';
                              }
                              return null;
                            },
                          )))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  height: 60,
                  child: RaisedButton(
                    onPressed: () {
                      bool valid = formkey.currentState.validate();
                      // ignore: unnecessary_statements
                      valid ? onSave(context) : () {};
                    },
                    color: Colors.green,
                    child: Text(
                      'SIGN UP',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
            FlatButton(
              child: Text('Log in'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}

// class BackButtonWidget extends StatelessWidget {
//   const BackButtonWidget({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 200,
//       // decoration: BoxDecoration(
//       //     image: DecorationImage(
//       //         fit: BoxFit.cover, image: AssetImage('assets/images/sign.jpg'))),
//       child: Positioned(
//           child: Stack(
//         children: <Widget>[
//           Positioned(
//               top: 20,
//               child: Row(
//                 children: <Widget>[
//                   IconButton(
//                       icon: Icon(
//                         Icons.arrow_back_ios,
//                         color: Colors.white,
//                       ),
//                       onPressed: () {
//                         Navigator.pop(context);
//                       }),
//                   Text(
//                     'Back',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       shadows: <Shadow>[
//                         Shadow(
//                           offset: Offset(1.0, 1.0),
//                           blurRadius: 3.0,
//                           color: Color.fromARGB(255, 0, 0, 0),
//                         ),
//                         Shadow(
//                           offset: Offset(2.0, 2.0),
//                           blurRadius: 8.0,
//                           color: Color.fromARGB(255, 0, 0, 0),
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               )),
//           Positioned(
//             bottom: 20,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 'Create New Account',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w900,
//                   fontSize: 28,
//                   shadows: <Shadow>[
//                     Shadow(
//                       offset: Offset(1.0, 1.0),
//                       blurRadius: 3.0,
//                       color: Color.fromARGB(255, 0, 0, 0),
//                     ),
//                     Shadow(
//                       offset: Offset(2.0, 2.0),
//                       blurRadius: 8.0,
//                       color: Color.fromARGB(255, 0, 0, 0),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           )
//         ],
//       )),
//     );
//   }
// }
