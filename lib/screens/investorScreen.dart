import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guide/res/custom_colors.dart';
import 'package:guide/database/database.dart';
import 'package:guide/screens/organizationScreen.dart';

import 'package:guide/widgets/alert_dialog.dart';
import 'package:guide/screens/rating.dart';
import 'package:guide/screens/user_info_screen.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:connectivity/connectivity.dart';

class InvestorScreen extends StatefulWidget {
  const InvestorScreen({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;
  @override
  _InvestorScreenState createState() => _InvestorScreenState();
}

class _InvestorScreenState extends State<InvestorScreen> {
  late bool _isEmailVerified;
  late User _user;

  Map _messagecomp = {};
  List _startups = ["Face Detection", "Startup Monitoring", "Search Engine"];
  List updateList = [];

  bool update = false;
  var url;

  bool _verificationEmailBeingSent = false;
  bool _isSigningOut = false;

  bool _isComposing = false;
  bool checknetConnection = false;
  final TextEditingController _alertTextField = TextEditingController();

  @override
  void initState() {
    super.initState();
    checkUpdate();
    checkConnectivity();
    _user = widget._user;
    _isEmailVerified = _user.emailVerified;
  }

  checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      setState(() {
        checknetConnection = true;
      });
    } else if (connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        checknetConnection = true;
      });
    } else {
      checknetConnection = false;
    }
  }

  checkUpdate() async {
    dynamic resultant = await updateApp();

    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      updateList = resultant;
      update = updateList[0]["Update"];
      url = updateList[0]["Link"];
    }
  }

  @override
  Widget build(BuildContext context) {
    // Update Body
    Widget updatebody = Scaffold(
      appBar: AppBar(
        title: Text(
          "Update Available",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).backgroundColor),
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(top: 200),
              child: Column(
                children: [
                  Text(
                    "The Update of this App is Available",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "Please Install New Version for Better Experince",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        CustomColors.firebaseOrange,
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    onPressed: () {
                      launch(url);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                      child: Text(
                        'Update',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.firebaseGrey,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );

    Widget noInternet = Scaffold(
      appBar: AppBar(
        title: Text(
          "No Internet",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).backgroundColor),
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Icon(
                    Icons.network_check,
                    size: 100,
                  ),
                  Text(
                    "Not Internet Connection",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "This App need Internet to fetch Startups Ideas",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    "So Please Connect Your Internet",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        CustomColors.firebaseOrange,
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        checkConnectivity();
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                      child: Text(
                        'Retry',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.firebaseGrey,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );

    // main Activity body
    Widget mainBody = Scaffold(
        backgroundColor: CustomColors.buttonColor,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColor),
                child: Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 50,
                      color: CustomColors.firebaseGrey,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget._user.displayName!,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Text(
                            widget._user.email!,
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                        ]),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Organization Page'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OrganizationScreen(user: _user)),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Account'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserInfoScreen(
                              user: _user,
                            )),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.rate_review),
                title: Text('Rate this App'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RateApp(user: _user)),
                  );
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text("Startups"),
          elevation:
              Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
        ),
        body: Container(
          decoration: Theme.of(context).platform == TargetPlatform.iOS //new
              ? BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey[200]!),
                  ),
                )
              : null,
          child: Column(
            children: [
              Flexible(
                child: _startups.isEmpty
                    ? Center(
                        child: CircleAvatar(
                        radius: 100,
                        child: Image.asset("assets/logo.png"),
                      ))
                    : ListView.builder(
                        padding: const EdgeInsets.all(8.0),
                        itemCount: _startups.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            color: Colors.grey[850],
                            child: Padding(
                              padding: EdgeInsets.only(left: 10, right: 0),
                              child: ListTile(
                                title: Text('${_startups[index]}'),
                                onTap: () {},
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ));
    return checknetConnection
        ? update
            ? updatebody
            : mainBody
        : noInternet;
  }

  @override
  void dispose() {
    for (var message in _startups) {
      message.dispose();
    }

    checkConnectivity().dispose();

    super.dispose();
  }
}
