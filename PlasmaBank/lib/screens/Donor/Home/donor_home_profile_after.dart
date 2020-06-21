import 'package:PlasmaBank/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:PlasmaBank/screens/Donor/donor_user.dart';
import 'package:provider/provider.dart';
import 'package:PlasmaBank/services/donor_auth.dart';
import 'package:PlasmaBank/screens/Donor/Home/donor_home_profile_after_approval.dart';


class DonorHomeProfileAfter extends StatefulWidget {
  @override
  _DonorHomeProfileAfterState createState() => _DonorHomeProfileAfterState();
}

class _DonorHomeProfileAfterState extends State<DonorHomeProfileAfter> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            'We received your application. We will notify you soon when your account will be ready and you can start donating Plasma',
            style: TextStyle(
              color: Colors.white,
            ),
            ),
        ),
      ),
    );
  }
}