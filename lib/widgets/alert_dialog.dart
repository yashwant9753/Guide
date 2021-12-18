import 'package:firebase_auth/firebase_auth.dart';
import 'package:guide/res/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:guide/database/database.dart';
import 'package:intl/intl.dart';

nana(User user, Map message) {
  print(message);
}

class AlertMessage extends StatefulWidget {
  AlertMessage({required User user, required Map message})
      : _user = user,
        _messagecomp = message;

  final User _user;
  final Map _messagecomp;
  @override
  _AlertMessageState createState() =>
      _AlertMessageState(newmessage: _messagecomp);
}

class _AlertMessageState extends State<AlertMessage> {
  _AlertMessageState({required Map newmessage}) : _messagecomp = newmessage;
  late Map _messagecomp;
  late User _user;

  List documentIdlist = [];

  final TextEditingController _alertTextField = TextEditingController();
  String dropdown = DateFormat.yMMMEd().format(DateTime.now());
  // var std = new InvestorScreen();
  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
  }

  fetchDatabaseList() async {
    dynamic resultant = await getUserDate(widget._user.email);

    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        documentIdlist = resultant;
        if (documentIdlist.contains(dropdown)) {
        } else {
          documentIdlist.add(DateFormat.yMMMEd().format(DateTime.now()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("SAVE AS"),
      content: Container(
        height: MediaQuery.of(context).size.height / 8,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              DropdownButton(
                  icon: const Icon(Icons.arrow_drop_down_circle_outlined),
                  iconSize: 30,
                  isExpanded: true,
                  style: const TextStyle(color: Colors.black87),
                  value: dropdown,
                  items: documentIdlist.map((itemname) {
                    return DropdownMenuItem(
                        value: itemname,
                        child: Text(
                          itemname,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'PT_Sans'),
                        ));
                  }).toList(),
                  onChanged: (dynamic newValue) {
                    setState(() {
                      dropdown = newValue!;
                    });
                  }),
              TextField(
                controller: _alertTextField,
                decoration: InputDecoration(hintText: "Save As"),
              ),
            ]),
      ),
      elevation: 50,
      actions: <Widget>[
        FlatButton(
          child: new Text('CANCEL'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: new Text('SAVE'),
          onPressed: () {
            if (_alertTextField.text.isEmpty) {
              addItem(widget._user.email, dropdown, _messagecomp);
              Navigator.of(context).pop();

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Row(
                children: [
                  Icon(
                    Icons.thumb_up,
                    color: CustomColors.firebaseOrange,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Successfully Saved As $dropdown")
                ],
              )));
            } else {
              addItem(widget._user.email, _alertTextField.text, _messagecomp);
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Row(
                children: [
                  Icon(
                    Icons.thumb_up,
                    color: CustomColors.firebaseOrange,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Successfully Saved As ${_alertTextField.text}")
                ],
              )));
            }
          },
        )
      ],
    );
  }
}
