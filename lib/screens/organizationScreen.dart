import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:guide/database/database.dart';
import 'package:intl/intl.dart';
import 'package:guide/screens/rating.dart';
import 'package:guide/screens/user_info_screen.dart';
import 'package:guide/res/custom_colors.dart';

class OrganizationScreen extends StatefulWidget {
  const OrganizationScreen({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  State<OrganizationScreen> createState() => _OrganizationScreenState();
}

class _OrganizationScreenState extends State<OrganizationScreen> {
  late bool _isEmailVerified;
  late User _user;
  Map _messagecomp = {};
  List _messages = [];

  void initState() {
    super.initState();
    _user = widget._user;
    _isEmailVerified = _user.emailVerified;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
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
                  MaterialPageRoute(builder: (context) => RateApp(user: _user)),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(
          "Added Startup Ideas",
          style: TextStyle(color: Colors.white),
        ),
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
              child: _messages.isEmpty
                  ? Center(
                      child: RichText(
                          text: TextSpan(
                              text: "Add startup Ideas",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w100,
                                  letterSpacing: 5,
                                  fontFamily: 'PT_Sans'))),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(8.0),
                      itemCount: _messages.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                            color: _messagecomp[_messages[index]]
                                ? Colors.green
                                : Colors.grey[850],
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: ListTile(
                                title: Text('${_messages[index]}'),
                              ),
                            ));
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.add,
          size: 40,
        ),
      ),
    );
  }
}
