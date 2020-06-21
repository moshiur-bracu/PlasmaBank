import 'package:PlasmaBank/screens/Donor/Home/receiver_list.dart';
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

  final List<String> bloodGroups = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  final List<String> cities = ['Dhaka', 'Sylhet', 'Chittagong', 'Rajshahi', 'Khulna', 'Barishal', 'Rangpur'];

  String city;
  String bloodGroup;
  bool searchedItem = true;
  bool search = true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: kPrimaryColor,
          body: StreamProvider<List<ReceiverModel>>.value(
        initialData: List(),
        value: search ? ReceiverDatabaseService().receivers : searchedItem ? ReceiverDatabaseService().fetchReceiversBloodGroups(bloodGroup) : ReceiverDatabaseService().fetchReceiversCities(city),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: <Widget>[
              /*SearchBox(
                onChanged: (value) {
                  searchedItem = value;
                },
              ),*/
              SizedBox(height: kDefaultPadding/2),
              Row(
                children: <Widget> [
                Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: DropdownButtonFormField(
                    value: city ?? 'Dhaka',
                    decoration: textInputDecoration,
                    items: cities.map((city) {
                      return DropdownMenuItem(
                        value: city,
                        child: Text('$city'),
                      );
                    }).toList(),
                    onChanged: (valCi) {
                      setState(() {
                        city = valCi;
                        search = false;
                        searchedItem = false;
                      });
                    },
                    ),
                                ),
                ),
                  SizedBox(height: 10.0),
                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: DropdownButtonFormField(
                    value: bloodGroup ?? 'A+',
                    decoration: textInputDecoration,
                    items: bloodGroups.map((bloodGroup) {
                      return DropdownMenuItem(
                        value: bloodGroup,
                        child: Text('$bloodGroup'),
                      );
                    }).toList(),
                    onChanged: (valB) {
                      setState(() {
                        bloodGroup = valB;
                        search = false;
                        searchedItem = true;
                      });
                    },
                    ),
                                    ),
                  ),
                ],
              ),
              RaisedButton(
                color: kSecondaryColor,
                onPressed: () { 
                  setState(() {
                    search = true;
                    city = null;
                    bloodGroup = null;
                  });
                },
                child: Text('Reset Filters'),
              ),
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
                    ReceiverList(),
                  ],
                ),
              ),
            ],
          ),
        ),
        ),
    );
  }
}

