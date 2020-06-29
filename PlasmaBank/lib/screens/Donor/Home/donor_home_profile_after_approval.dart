import 'package:PlasmaBank/screens/Donor/Home/donor_home_form.dart';
import 'package:PlasmaBank/screens/Donor/donor_user.dart';
import 'package:PlasmaBank/shared/constants.dart';
import 'package:PlasmaBank/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:PlasmaBank/services/donor_auth.dart';

class DonorHomeProfileAfterApproval extends StatefulWidget {

  @override
  _DonorHomeProfileAfterApprovalState createState() => _DonorHomeProfileAfterApprovalState();
}

class _DonorHomeProfileAfterApprovalState extends State<DonorHomeProfileAfterApproval> {
  @override
  Widget build(BuildContext context) {

    final DonorAuthService _auth = DonorAuthService();
    final user = Provider.of<DonorUser>(context);
    
    return FutureBuilder(
        future: _auth.getDatabaseInstance(user.uid),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            //print('has data and not null');
            //print(snapshot.data);
            if (snapshot.data['approval'] == 'approved') {
              //print('approved');
              return Scaffold(
                body: SingleChildScrollView(
                                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Text('Name : '),
                        title: Text(snapshot.data['name']),
                      ),
                      ListTile(
                        leading: Text('Email : '),
                        title: Text(snapshot.data['email']),
                      ),
                      ListTile(
                        leading: Text('Blood Group : '),
                        title: Text(snapshot.data['bloodGroup']),
                      ),
                      ListTile(
                        leading: Text('City : '),
                        title: Text(snapshot.data['city']),
                      ),
                      ListTile(
                        leading: Text('Contact Number : '),
                        title: Text(snapshot.data['contactNumber']),
                      ),
                      ListTile(
                        leading: Text('Positive Date : '),
                        title: Text(snapshot.data['positiveDate']),
                      ),
                      ListTile(
                        leading: Text('Negative Date : '),
                        title: Text(snapshot.data['negativeDate']),
                      ),
                      ListTile(
                        leading: Text('Last Donation: '),
                        title: Text(snapshot.data['lastDonation']),
                      ),
                      ListTile(
                        leading: Text('Number of Donations'),
                        title: Text(snapshot.data['donationTimes']),
                      ),
                      ListTile(
                        leading: Text('New Symptoms : '),
                        title: Text(snapshot.data['newSymptoms']),
                      ),
                      ListTile(
                        leading: Text('Pregnancy or Abortion'),
                        title: Text(snapshot.data['pregnancyOrAbortion']),
                      ),
                      ListTile(
                        leading: Text('Viral Diseases'),
                        title: Text(snapshot.data['viralDiseases']),
                      ),
                      SizedBox(height: 15.0),
                      RaisedButton(
                        color: kSecondaryColor,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DonorForm()),
                          );
                        },
                        child: Text(
                          'Update Info',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          ),
                      ),
                      SizedBox(height: 40),
                    ],
                  ),
                ),
              );
            }
            else return Loading();
          } 
          else {
            return Loading();
          }
        });
  }
}