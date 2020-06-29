
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
          shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(20.0)),
          color: Colors.white,
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25.0,
              backgroundColor: bloodRed,
              child: Text(
                widget.receiverModel.bloodGroup,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  ),
              ),
            ),
            title: Text(widget.receiverModel.name),
            subtitle: Text(widget.receiverModel.contactNumber),
            trailing: buttonChange ? Container(
              height: 200,
              width: 100,
              child: Column(
                children: <Widget>[
                  ButtonTheme(
                minWidth: 100.0,
                height: 45.0,
                buttonColor: kSecondaryColor,
                            child: RaisedButton(
                              elevation: 5.0,
                    shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                  onPressed: () async {
                                          await _makePhoneCall(widget.receiverModel.contactNumber);
                                          Firestore.instance.collection('Plasma Requests').document(widget.receiverModel.id).delete();
                                        }, 
                  child: Text(
                    'Call',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    ),
                ),
              ),
              /*ButtonTheme(
                minWidth: 100.0,
                height: 45.0,
                buttonColor: kSecondaryColor,
                            child: RaisedButton(
                              elevation: 5.0,
                    shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                  onPressed: () async {
                                          setState(() {
                                            buttonChange = false;
                                          });
                                          accepted = 'false';
                                          await ReceiverDatabaseService(uid: widget.receiverModel.id).updateUserDataAccepted(accepted);
                                        },  
                  child: Text(
                    'Decline',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    ),
                ),
              ),*/
              ],
              ),
            )
             : ButtonTheme(
              minWidth: 100.0,
              height: 45.0,
              buttonColor: kRecovercolor,
                          child: RaisedButton(
                            elevation: 5.0,
                  shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
                onPressed: () async {
                                          setState(() {
                                          isButtonPressed =!isButtonPressed;
                                          buttonChange = true;
                                        });
                                        //print(widget.receiverModel.id);
                                        accepted = 'true';
                                        await ReceiverDatabaseService(uid: widget.receiverModel.id).updateUserDataAccepted(accepted);
                                        },
                child: Text(
                  'Accept',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  ),
              ),
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
  //print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

