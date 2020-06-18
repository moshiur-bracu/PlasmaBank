import 'package:PlasmaBank/screens/Donor/Authenticate/donor_register.dart';
import 'package:PlasmaBank/screens/Donor/Authenticate/donor_sign_in.dart';
import 'package:flutter/material.dart';

class DonorAuthenticate extends StatefulWidget {
  @override
  _DonorAuthenticateState createState() => _DonorAuthenticateState();
}

class _DonorAuthenticateState extends State<DonorAuthenticate> {

  bool showSignIn = true;
  void toggleView(){
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return DonorSignIn(toggleView:  toggleView);
    } else {
      return DonorRegister(toggleView:  toggleView);
    }
  }
}