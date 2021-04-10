import 'package:flutter/material.dart';
import './search.dart';

class CustomDialog extends StatelessWidget {
  String infoListName;
  String infoListStuFac;
  String infoListRollOfficenum;

  CustomDialog(String name, String person, String number) {
    this.infoListName = name;
    this.infoListStuFac = person;
    this.infoListRollOfficenum = number;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
    );
  }

  _buildChild(BuildContext context) => Container(
        height: 350,
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Column(
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: CircleAvatar(child: Icon(Icons.android)),
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12))),
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              infoListName,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(infoListStuFac),
                  VerticalDivider(
                    color: Colors.black,
                  ),
                  Text((infoListRollOfficenum).toString()),
                ],
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  width: 8,
                ),
                RaisedButton(
                  onPressed: () {
                    return Navigator.of(context).pop(true);
                  },
                  child: Text('SEND MAIL'),
                  color: Colors.white,
                  textColor: Colors.redAccent,
                )
              ],
            )
          ],
        ),
      );
}
