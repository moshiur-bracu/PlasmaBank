import 'package:PlasmaBank/screens/Donor/Home/receiver_list.dart';
import 'package:PlasmaBank/screens/Donor/Home/receiver_tile.dart';
import 'package:PlasmaBank/shared/componets.dart';
import 'package:PlasmaBank/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:PlasmaBank/services/database_receiver.dart';
import 'package:PlasmaBank/screens/Donor/receiver_model.dart';

class DonorRequests extends StatefulWidget {
  @override
  _DonorRequestsState createState() => _DonorRequestsState();
}

class _DonorRequestsState extends State<DonorRequests> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<ReceiverModel>>.value(
      initialData: List(),
      value: ReceiverDatabaseService().receivers,
      //child: Scaffold(
      //  body: ReceiverList(),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: <Widget>[
            SearchBox(
              onChanged: (value) {},
            ),
            SizedBox(height: kDefaultPadding/2),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 70),
                    decoration: BoxDecoration(
                      color: kBackgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                  ),
                  ReceiverList()
                ],
              ),
            ),
          ],
        ),
      ),
      );
  }
}