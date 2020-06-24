import 'package:PlasmaBank/screens/wrapper.dart';
import 'package:PlasmaBank/services/donor_auth.dart';
import 'package:PlasmaBank/shared/constants.dart';
import 'package:PlasmaBank/shared/loading.dart';
import 'package:flutter/material.dart';

class DonorRegister extends StatefulWidget {

  final Function toggleView;
  DonorRegister({ this.toggleView });

  @override
  _DonorRegisterState createState() => _DonorRegisterState();
}

class _DonorRegisterState extends State<DonorRegister> {

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
        title: Text('Sign up to PlasmaBank'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text(
              'Sign In',
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
          child: ListView(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                maxLines: 1,
                autofocus: false,
                keyboardType: TextInputType.emailAddress,
                decoration: textInputDecoration.copyWith(hintText: 'Email', icon: Icon(Icons.mail, color: Colors.white,)),
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                maxLines: 1,
                autofocus: false,
                keyboardType: TextInputType.emailAddress,
                decoration: textInputDecoration.copyWith(hintText: 'Password', icon: Icon(Icons.lock, color: Colors.white,)),
                obscureText: true,
                validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
                child: SizedBox(
                height: 40.0,
                width: 300.0,
                child: new RaisedButton(
                  onPressed: () async {
                  if(_formKey.currentState.validate()){
                    setState(() => loading = true);
                    
                    dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                    if(result == null) {
                      setState(() {
                        loading = false;
                        error = 'Please supply a valid email';
                      });
                    }
                  }
                },
                  elevation: 5.0,
                  shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
                  color: kSecondaryColor,
                  child: new Text('Register',
                    style: new TextStyle(fontSize: 20.0, color: Colors.white)),
                  ),
                  ),
              ),
              SizedBox(height: 20.0),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          ),
        ),
      ),
            ),
    );
  }
}