import 'package:flutter/material.dart';
import 'package:PlasmaBank/services/donor_auth.dart';
import 'package:PlasmaBank/screens/Donor/donor_wrapper.dart';
import 'package:provider/provider.dart';
import 'package:PlasmaBank/screens/Donor/donor_user.dart';

class DonorProvider extends StatelessWidget {
  // This widget is the root of Donor
  @override
  Widget build(BuildContext context) {
    return StreamProvider<DonorUser>.value(
      value: DonorAuthService().user,
      child: DonorWrapper()
    );
  }
}