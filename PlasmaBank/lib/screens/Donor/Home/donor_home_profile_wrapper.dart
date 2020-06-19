import 'package:PlasmaBank/screens/Donor/Home/donor_home_profile_after_approval.dart';
import 'package:PlasmaBank/screens/Donor/donor_user.dart';
import 'package:PlasmaBank/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:PlasmaBank/services/donor_auth.dart';
import 'package:PlasmaBank/screens/Donor/Home/donor_home_profile_before.dart';
import 'package:PlasmaBank/screens/Donor/Home/donor_home_profile_after.dart';

class DonorProfileWrapper extends StatefulWidget {
  @override
  _DonorProfileWrapperState createState() => _DonorProfileWrapperState();
}

class _DonorProfileWrapperState extends State<DonorProfileWrapper> {
  @override
  Widget build(BuildContext context) {
    final DonorAuthService _auth = DonorAuthService();
    final user = Provider.of<DonorUser>(context);
    return FutureBuilder(
        future: _auth.getDatabaseInstance(user.uid),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            if (snapshot.data['name'] == 'name') {
              print(snapshot.data['name']);
              return DonorHomeProfileBefore();
            } else {
              if(snapshot.data['approval'] == 'approved')
              {
                print(snapshot.data['approval']);
                return DonorHomeProfileAfterApproval();
              }
              else {
                print(snapshot.data['approval']);
                return DonorHomeProfileAfter();
              }
            }
          } else {
            //print(snapshot.data['approval']);
            return Loading();
          }
        });
  }
}
