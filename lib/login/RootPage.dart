
import 'package:restaurent_app/HomePage.dart';
import 'package:restaurent_app/login/LoginAuth.dart';
import 'package:flutter/material.dart';
import 'auth.dart';

class Root extends StatefulWidget {
  Root({this.auth, this.onSignedIn, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final VoidCallback onSignedIn;
  _RootState createState() => _RootState();
  }


enum AuthStatus {
  notsignedIn,
  signedIn,
}

class _RootState extends State<Root>{
  AuthStatus authStatus = AuthStatus.notsignedIn;
  @override
  void initState() {
    super.initState();
      widget.auth.currentUser().then((userId) {
        setState(() {
          authStatus =
              userId == null ? AuthStatus.notsignedIn : AuthStatus.signedIn;
        });   
      });
 
  }

  void _signedIn() async {
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  void _signOut() async {
    setState(() {
      authStatus = AuthStatus.notsignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notsignedIn:
        return new LoginAuth(
          auth: widget.auth,
          onSignedIn: _signedIn,
        );
      case AuthStatus.signedIn:
        return new Home(
          auth: widget.auth,
          onSignedOut: _signOut,
        );
    }
    return null;
  }
}
