import 'package:PlasmaBank/screens/Donor/Home/donor_home_profile_wrapper.dart';
import 'package:PlasmaBank/screens/Donor/Home/donor_home_request_wrapper.dart';
import 'package:PlasmaBank/screens/home.dart';
import 'package:PlasmaBank/screens/wrapper.dart';
import 'package:PlasmaBank/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:PlasmaBank/services/donor_auth.dart';

class DonorHome extends StatelessWidget {

  final DonorAuthService _auth = DonorAuthService();

  final PersistentTabController _controller = PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
        return [
          Home(),
          DonorHomeRequestWrapper(),
          DonorProfileWrapper()
        ];
  }

    List<PersistentBottomNavBarItem> _navBarsItems() {
        return [
        PersistentBottomNavBarItem(
            icon: Icon(CupertinoIcons.home),
            title: ("Home"),
            activeColor: CupertinoColors.activeBlue,
            inactiveColor: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
            icon: Icon(CupertinoIcons.settings),
            title: ("Requests"),
            activeColor: CupertinoColors.activeBlue,
            inactiveColor: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
            icon: Icon(CupertinoIcons.settings),
            title: ("Profile"),
            activeColor: CupertinoColors.activeBlue,
            inactiveColor: CupertinoColors.systemGrey,
        ),
        ];
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            centerTitle: false,
            title: Text('PlasmaBank'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {},
              ),
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () async {
                await _auth.signOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Wrapper()),
                    );
              },
            ),
          ],
        ),
            body: PersistentTabView(
          controller: _controller,
          items: _navBarsItems(),
          screens: _buildScreens(),
          showElevation: true,
          navBarCurve: NavBarCurve.upperCorners,
          confineInSafeArea: true,
          handleAndroidBackButtonPress: true,
          iconSize: 26.0,
          navBarStyle: NavBarStyle.style6, // Choose the nav bar style with this property
          onItemSelected: (index) {
              print(index);
          },
          
        ),      
    );
  }
}

    