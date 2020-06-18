import 'package:PlasmaBank/screens/Receiver/receiver_form.dart';
import 'package:PlasmaBank/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:PlasmaBank/screens/Donor/donor_provider.dart';
import 'package:PlasmaBank/services/receiver_auth.dart';
import 'package:PlasmaBank/shared/loading.dart';

class Wrapper extends StatefulWidget {

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                setState(() {
                  loading = true;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DonorProvider()),
                  );
              },
              child: Text('DONATE PLASMA'),
            ),

            RaisedButton(
              onPressed: () async {
                setState(() {
                  loading = true;
                });
                final ReceiverAuthService _auth = ReceiverAuthService();
                dynamic result = await _auth.signInAnon();
                  if(result == null) {
                    setState(() {
                      loading = false;
                    });
                    print('Error Signinig In');
                  }
                  else {
                    print('Signed In');
                    print(result.uid);
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ReceiverForm()),
                  );
                }
              },
              child: Text('NEED PLASMA'),
            ),


          ],
        ),
      ),
    );
  }
}