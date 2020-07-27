import 'package:flutter/cupertino.dart';
import 'package:flutterapp/button.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/person.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  List<dynamic> people = [
    Student(name: "A", rollno: "RnA", hostel: "Cau", email: "rna", room: 204),
    Student(name: "B", rollno: "RnB", hostel: "Gan", email: "rnb", room: 128),
    Student(name: "C", rollno: "RnC", hostel: "Sar", email: "rnc", room: 317),
    Student(name: "D", rollno: "RnD", hostel: "Sha", email: "rnd", room: 145),
    Faculty(name: "W", office: "HSB202", officenum: 235569, email: "EmW"),
    Faculty(name: "X", office: "HSB202", officenum: 235569, email: "EmX"),
    Faculty(name: "Y", office: "ESB202", officenum: 235569, email: "EmY"),
    Faculty(name: "Z", office: "MSB202", officenum: 235569, email: "EmZ"),
  ];

  List filteredList = List();

  @override
  void initState() {
    super.initState();
    filteredList = people;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  "FIND PEOPLE",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 0,
              ),
              child: Material(
                elevation: 3.0,
                shadowColor: Colors.deepPurple[500],
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(4.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple[500], width: 0),
                    ),
                    prefixIcon: Icon(Icons.search),
                    hintText: "You'll find her, even roll number works",
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 0),
              child: CustomRadioButton(
                elevation: 0,
                height: 25.0,
                fontSize: 12.0,
                autoWidth: true,
                enableShape: true,
                buttonLabels: ["EVERYONE", "STUDENT", "FACULTY"],
                unSelectedColor: Colors.white,
                buttonValues: ["EVERYONE", "STUDENT", "FACULTY"],
                radioButtonValue: (value){
                  if(value == "EVERYONE"){
                    setState(() {
                      filteredList = people;
                    });
                  }else if(value == "STUDENT") {
                    setState(() {
                      filteredList = people.where((p) => p is Student).toList();
                    });
                  }else {
                    setState(() {
                      filteredList = people.where((p) => p is Faculty).toList();
                    });
                  }
                },
                selectedColor: Colors.deepPurple[500],
                defaultSelected: "EVERYONE",
                customShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(3.5)),
                  side: BorderSide(
                    color: Colors.deepPurple[500],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 1.0,
                  color: Colors.grey[600],
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  thickness: 1.0,
                  height: 37.0,
                  color: Colors.grey[600],
                ),
                itemCount: filteredList.length,
                itemBuilder: (context, index){
                  return ListTile(
                    onTap: () {},
                    title: Text(filteredList[index].name),
                    leading: CircleAvatar(child: Icon(Icons.android)),
                    subtitle: IntrinsicHeight(
                      child: Row(
                        children: <Widget>[
                          filteredList[index] is Student ? Text("STUDENT")
                              : filteredList[index] is Faculty ? Text("FACULTY") : null,
                          VerticalDivider(
                            color: Colors.black,
                          ),
                          filteredList[index] is Student ? Text(filteredList[index].rollno)
                              : filteredList[index] is Faculty ? Text((filteredList[index].officenum).toString()) : null,
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text("Settings")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            title: Text("Call")
          ),
        ],
      ),
    );
  }
}
