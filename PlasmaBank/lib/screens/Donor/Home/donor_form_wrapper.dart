import 'package:PlasmaBank/screens/Donor/Home/donor_form_home_after.dart';
import 'package:PlasmaBank/screens/Donor/Home/donor_form_home_before.dart';
import 'package:PlasmaBank/screens/Donor/donor_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:PlasmaBank/services/donor_auth.dart';

class DonorFormWrapper extends StatefulWidget {
  @override
  _DonorFormWrapperState createState() => _DonorFormWrapperState();
}

class _DonorFormWrapperState extends State<DonorFormWrapper> {
  @override
  Widget build(BuildContext context) {
    final DonorAuthService _auth = DonorAuthService();
    final user = Provider.of<DonorUser>(context);
    return FutureBuilder(
        future: _auth.getDatabaseInstance(user.uid),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            if (snapshot.data['name'] == 'name') {
              return DonorFormHomeBefore();
            }
            return DonorFormHomeAfter();
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
