
import 'package:flutter/material.dart';
import 'package:PlasmaBank/screens/Donor/receiver_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:PlasmaBank/services/database_receiver.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:PlasmaBank/shared/constants.dart';

class ReceiverTile extends StatefulWidget {

  final ReceiverModel receiverModel;
  ReceiverTile({ this.receiverModel });
  

  @override
  _ReceiverTileState createState() => _ReceiverTileState();
}

class _ReceiverTileState extends State<ReceiverTile> {

  bool isButtonPressed = false;
  bool buttonChange = false; 
  String accepted = 'false';
  bool accept = false;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.red[800],
            child: Text(
              widget.receiverModel.bloodGroup,
              style: TextStyle(
                color: Colors.white
                ),
            ),
          ),
          title: Text(widget.receiverModel.name),
          subtitle: Text(widget.receiverModel.contactNumber),
          trailing: buttonChange ? RaisedButton.icon(
                                    onPressed: () async {
                                      await _makePhoneCall(widget.receiverModel.contactNumber);
                                      Firestore.instance.collection('Plasma Requests').document(widget.receiverModel.id).delete();
                                    }, 
                                    icon: Icon(Icons.call), 
                                    label: Text('Call'),
                                    color: Colors.green,
                                    ) : 
                                    RaisedButton.icon(
                                      color: kBlueColor,
                                      onPressed: () async {
                                        setState(() {
                                        isButtonPressed =!isButtonPressed;
                                        buttonChange = true;
                                      });
                                      print(widget.receiverModel.id);
                                      accepted = 'true';
                                      await ReceiverDatabaseService(uid: widget.receiverModel.id).updateUserDataAccepted(accepted);
                                      }, 
                                      icon: Icon(Icons.check), 
                                      label: Text('Accept'),
                                      ),
          isThreeLine: true,
        ),
      ),
    );
    
  }
  
}

Future<void> _makePhoneCall(String url) async {
  //Firestore.instance.collection('Plasma Requests').document(widget.receiverModel.id).delete();
  url = 'tel:$url';
  print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

