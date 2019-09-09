import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'auth.dart';

enum FormType { home, login, createacc, updateacc }
class LoginAuth extends StatefulWidget {
  LoginAuthState createState() => LoginAuthState();
  LoginAuth({this.auth, this.onSignedIn});
  final BaseAuth auth;
  final VoidCallback onSignedIn;
  static String address;
  static String phone;
  static String email;
  static String cpassword;
  static String password;
  final emailController = TextEditingController();
  final pwdController = TextEditingController();
}

class LoginAuthState extends State<LoginAuth> {
  final String bgImg = "assets/burger1new.jpg";
  final String loGo = "assets/logo.png";
  FormType _formType = FormType.home;
  final formKey = GlobalKey<FormState>();

  bool validateAndSave() {
    final form = formKey.currentState;
    form.save();
    if (form.validate()) {
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        FirebaseUser user;
        user = await widget.auth.signIn(LoginAuth.email, LoginAuth.password);
        print(user);
        widget.onSignedIn();
      } catch (e) {
        print("Error $e");
      }
    }
  }

  void createAndUpdate() async {
    try {
      if (validateAndSave()) {
        await widget.auth
            .createUser(LoginAuth.email, LoginAuth.cpassword)
            .then((FirebaseUser user) {
          mtUpdate();
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void authenticateUser(FirebaseUser user) {
    final form = formKey.currentState;
    form.save();
    widget.auth.addToDb(user);
    widget.onSignedIn();
  }

  void completeAndUpdate() async {
    if (validateAndSave()) {
      try {
        final form = formKey.currentState;
        form.save();
        await widget.auth
            .signIn(LoginAuth.email, LoginAuth.password)
            .then((FirebaseUser user) {
          authenticateUser(user);
        });
      } catch (e) {
        print(e);
      }
    }
  }

  void mtUpdate() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.updateacc;
    });
  }

  void mtLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  void mtReg() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.createacc;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(bgImg),
          ),
        ),
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                margin: const EdgeInsets.all(55.0),
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 55.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: BackdropFilter(
                    filter: ImageFilter.blur(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Form(
                          key: formKey,
                          child: SingleChildScrollView(
                            child: new Column(
                              children: buildForm(),
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> buildForm() {
    switch (_formType) {
      case FormType.home:
        return [
          Icon(
            Icons.restaurant_menu,
            size: 65,
            color: Colors.grey.shade700,
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            "Restaurant",
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Restaurant App",
            style: TextStyle(fontSize: 25),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          SizedBox(
              width: double.infinity,
              child: RaisedButton(
                  elevation: 0,
                  focusElevation: 0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text("Create an Account"),
                  onPressed: mtReg)),
          const SizedBox(height: 15),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: "Already have an account?",
                style: TextStyle(fontSize: 18)),
            TextSpan(
                text: "Login",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                recognizer: new TapGestureRecognizer()
                  ..onTap = () => mtLogin()),
          ]))
        ];
      case FormType.login:
        return [
          Icon(
            Icons.restaurant_menu,
            size: 55,
            color: Colors.grey.shade700,
          ),
          const SizedBox(
            height: 7.0,
          ),
          Text(
            "Restaurant",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          new TextFormField(
            decoration: InputDecoration(labelText: "Email"),
            validator: (value) =>
                value.isEmpty ? "Email can\'t be empty" : null,
            onSaved: (String value) => LoginAuth.email = value,
            keyboardType: TextInputType.emailAddress,
            controller: widget.emailController,
          ),
          new TextFormField(
            decoration: InputDecoration(labelText: "Password"),
            obscureText: true,
            onSaved: (String value) => LoginAuth.password = value,
            validator: (value) =>
                value.isEmpty ? "Password can\'t be empty" : null,
            controller: widget.pwdController,
          ),
          const SizedBox(height: 7),
          SizedBox(
            width: double.infinity,
            child: RaisedButton(
              elevation: 5,
              focusElevation: 0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Text("Login"),
              onPressed: validateAndSubmit,
            ),
          ),
          const SizedBox(height: 8),
          Text.rich(TextSpan(children: [
            TextSpan(text: "New here? ", style: TextStyle(fontSize: 18)),
            TextSpan(
                text: "Create an account",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                recognizer: new TapGestureRecognizer()..onTap = () => mtReg()),
          ])),
          /*FlatButton(
            onPressed: (){},
            child: Text("Reset Password"),
          )*/
        ];
      case FormType.createacc:
        return [
          Icon(
            Icons.restaurant_menu,
            size: 55,
            color: Colors.grey.shade700,
          ),
          const SizedBox(
            height: 7.0,
          ),
          Text(
            "Restaurant",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          new TextFormField(
            decoration: InputDecoration(labelText: "Email"),
            validator: (value) =>
                value.isEmpty ? "Email can\'t be empty" : null,
            onSaved: (String value) => LoginAuth.email = value,
            keyboardType: TextInputType.emailAddress,
            controller: widget.emailController,
          ),
          new TextFormField(
            decoration: InputDecoration(labelText: "Password"),
            obscureText: true,
            validator: (value) =>
                value.isEmpty ? "Password can\'t be empty" : null,
            onSaved: (String value) => LoginAuth.password = value,
          ),
          new TextFormField(
            decoration: InputDecoration(labelText: "Confirm Password"),
            validator: (value) => value.isEmpty
                ? "Password can\'t be empty"
                : value != LoginAuth.password ? "Password does not match" : null,
            obscureText: true,
            onSaved: (String value) => LoginAuth.cpassword = value,
            controller: widget.pwdController,
          ),
          const SizedBox(height: 7),
          SizedBox(
              width: double.infinity,
              child: RaisedButton(
                elevation: 5,
                focusElevation: 0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Text("Create an Account"),
                onPressed: createAndUpdate,
              )),
          const SizedBox(height: 8),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: "Already have an account?",
                style: TextStyle(fontSize: 18)),
            TextSpan(
                text: "Login",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                recognizer: new TapGestureRecognizer()
                  ..onTap = () => mtLogin()),
          ])),
        ];
      case FormType.updateacc:
        return [
          Icon(
            Icons.restaurant_menu,
            size: 55,
            color: Colors.grey.shade700,
          ),
          const SizedBox(
            height: 7.0,
          ),
          Text(
            "Add more details...",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Make it easy for us to reach you",
            style: TextStyle(fontSize: 22),
            textAlign: TextAlign.center,
          ),
          TextFormField(
            decoration: new InputDecoration(
              labelText: "Phone",
            ),
            validator: (value) =>
                value.isEmpty ? "Please enter your phone number" : null,
            onSaved: (String value) => LoginAuth.phone = value,
            keyboardType: TextInputType.phone,
          ),
          TextFormField(
            decoration: new InputDecoration(
              labelText: "Adress:",
            ),
            validator: (value) =>
                value.isEmpty ? "Please enter your address" : null,
            keyboardType: TextInputType.text,
            onSaved: (String value) => LoginAuth.address = value,
            maxLines: 2,
          ),
          SizedBox(
              width: double.infinity,
              child: RaisedButton(
                  elevation: 0,
                  focusElevation: 0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text("Update Info"),
                  onPressed: completeAndUpdate)),
          const SizedBox(height: 15),
        ];
    }
    return null;
  }
}