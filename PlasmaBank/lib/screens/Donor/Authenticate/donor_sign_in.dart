import 'package:PlasmaBank/screens/wrapper.dart';
import 'package:PlasmaBank/services/donor_auth.dart';
import 'package:PlasmaBank/shared/constants.dart';
import 'package:PlasmaBank/shared/loading.dart';
import 'package:flutter/material.dart';

class DonorSignIn extends StatefulWidget {

  final Function toggleView;
  DonorSignIn({ this.toggleView });

  @override
  _DonorSignInState createState() => _DonorSignInState();
}

class _DonorSignInState extends State<DonorSignIn> {

  final DonorAuthService _auth = DonorAuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
            onWillPop: () {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Wrapper()), (route) => false);
          return Future.value(false);
            }, child: loading ? Loading() : Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        elevation: 0.0,
        title: Text('Sign in to PlasmaBank'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text(
              'Register',
              style: TextStyle(
                color: Colors.white,
              ),
              ),
            onPressed: () => widget.toggleView(),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                obscureText: true,
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: kSecondaryColor,
                child: Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    setState(() => loading = true);
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if(result == null) {
                      setState(() {
                        loading = false;
                        error = 'Could not sign in with those credentials';
                      });
                    }
                  }
                }
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
            ),
    );
  }
}