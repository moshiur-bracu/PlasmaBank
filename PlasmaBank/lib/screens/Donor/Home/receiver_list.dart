import 'package:PlasmaBank/screens/Donor/Home/donor_home_requests.dart';
import 'package:PlasmaBank/screens/Donor/receiver_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:PlasmaBank/screens/Donor/Home/receiver_tile.dart';

class ReceiverList extends StatefulWidget {
  @override
  _ReceiverListState createState() => _ReceiverListState();
}

class _ReceiverListState extends State<ReceiverList> {
  @override
  Widget build(BuildContext context) {

    final receivers = Provider.of<List<ReceiverModel>>(context);
    
    return ListView.builder(
      itemCount: receivers.length,
      itemBuilder: (context, index) {
        return ReceiverTile(receiverModel: receivers[index]);
      },
    );
  }
}