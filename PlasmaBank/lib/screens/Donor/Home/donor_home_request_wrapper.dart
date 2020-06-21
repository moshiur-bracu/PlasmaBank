import 'package:PlasmaBank/screens/Donor/Home/donor_home_requests.dart';
import 'package:PlasmaBank/screens/Donor/Home/donor_home_requests_before.dart';
import 'package:PlasmaBank/screens/Donor/donor_user.dart';
import 'package:PlasmaBank/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:PlasmaBank/services/donor_auth.dart';

class DonorHomeRequestWrapper extends StatefulWidget {
  @override
  _DonorHomeRequestWrapperState createState() => _DonorHomeRequestWrapperState();
}

class _DonorHomeRequestWrapperState extends State<DonorHomeRequestWrapper> {
  @override
  Widget build(BuildContext context) {
    final DonorAuthService _auth = DonorAuthService();
    final user = Provider.of<DonorUser>(context);
    return FutureBuilder(
        future: _auth.getDatabaseInstance(user.uid),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            if (snapshot.data['approval'] == 'approved') {
              return DonorRequests();
            }
            return DonorRequestBefore();
          } else {
            return Loading();
          }
        });
  }
}