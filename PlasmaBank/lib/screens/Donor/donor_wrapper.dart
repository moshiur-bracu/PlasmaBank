import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:PlasmaBank/screens/Donor/donor_user.dart';
import 'package:PlasmaBank/screens/Donor/Authenticate/donor_authenticate.dart';
import 'package:PlasmaBank/screens/Donor/Home/donor_home.dart';

class DonorWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<DonorUser>(context);
    print(user);
    
    // return either the Home or Authenticate widget
    if (user == null){
      return DonorAuthenticate();
    } else {
      return DonorHome();
    }
  }
}