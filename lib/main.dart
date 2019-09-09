import 'package:flutter/material.dart';
import 'package:restaurent_app/login/auth.dart';
import 'package:restaurent_app/login/RootPage.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'bloc/cartListBloc.dart';
import 'bloc/listStyleColorBloc.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
@override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [Bloc((i) => CartListBLoc()), Bloc((i) => ColorBloc())],
        child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Restaurant App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.deepPurpleAccent,
        ),
        home: Root(auth: Auth()),
      ),
    );
  }
}