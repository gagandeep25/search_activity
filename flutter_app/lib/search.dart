import 'package:flutter/cupertino.dart';
import 'package:flutterapp/button.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/person.dart';
import './DialogOnTap.dart';

class Search extends StatefulWidget {
  @override
  SearchState createState() => SearchState();
}

class SearchState extends State<Search> {
  List<dynamic> people = [
    Student(
        name: "Ted Mosby",
        rollno: "EE12B290",
        hostel: "Cau",
        email: "rna",
        room: 204),
    Student(
        name: "Teda Mosby",
        rollno: "EE1290",
        hostel: "Ca",
        email: "rn",
        room: 20),
    Student(
        name: "Tedb Mosby",
        rollno: "EE2B90",
        hostel: "Cu",
        email: "ra",
        room: 24),
    Student(
        name: "Tedc Mosby",
        rollno: "E1B290",
        hostel: "au",
        email: "na",
        room: 04),
    Student(
        name: "Tede Mosby",
        rollno: "12B290",
        hostel: "Ca",
        email: "rn",
        room: 20),
    Student(
        name: "Robin Scherbatsky",
        rollno: "CS13B243",
        hostel: "Gan",
        email: "rnb",
        room: 128),
    Student(
        name: "Lily Aldrin",
        rollno: "ME12B295",
        hostel: "Sar",
        email: "rnc",
        room: 317),
    Student(
        name: "Marshal Eriksen",
        rollno: "HS15B090",
        hostel: "Sha",
        email: "rnd",
        room: 145),
    Faculty(name: "Ted", office: "HSB22", officenum: 25569, email: "EW"),
    Faculty(
        name: "Barney Stinson",
        office: "HSB202",
        officenum: 235569,
        email: "EmW"),
    Faculty(
        name: "Rachel Green",
        office: "HSB202",
        officenum: 235569,
        email: "EmX"),
    Faculty(
        name: "Chandler Bing",
        office: "ESB202",
        officenum: 235569,
        email: "EmY"),
    Faculty(
        name: "Joey Tribbiani",
        office: "MSB202",
        officenum: 235569,
        email: "EmZ"),
  ];

  List filteredList = List();
  List displayList = List();
  bool searched = false;

  bool searchHandler(item, String string) {
    bool value;
    if (string.length < 3) {
      value = false;
    } else {
      if (item is Student) {
        value = item.name.toLowerCase().contains(string.toLowerCase()) ||
            item.rollno.toLowerCase().contains(string.toLowerCase());
      } else {
        value = item.name.toLowerCase().contains(string.toLowerCase());
      }
    }
    return value;
  }

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
              child: Text("FIND PEOPLE",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 0,
              ),
              child: Material(
                elevation: 3.0,
                shadowColor: Colors.deepPurple[100],
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.deepPurple[500], width: 0),
                    ),
                    prefixIcon: Icon(Icons.search),
                    hintText: "You'll find her, even roll number works",
                  ),
                  onChanged: (string) {
                    setState(() {
                      string.length < 3 ? searched = false : searched = true;
                      filteredList = people
                          .where((p) => searchHandler(p, string))
                          .toList();
                      displayList = filteredList;
                    });
                  },
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
                radioButtonValue: (value) {
                  if (value == "EVERYONE") {
                    setState(() {
                      displayList = filteredList;
                    });
                  } else if (value == "STUDENT") {
                    setState(() {
                      displayList =
                          filteredList.where((p) => p is Student).toList();
                    });
                  } else {
                    setState(() {
                      displayList =
                          filteredList.where((p) => p is Faculty).toList();
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
                  height: 0.5,
                  color: Colors.deepPurple[100],
                ),
              ),
            ),
            Expanded(
              child: !searched
                  ? Text("No, you are not a stalker")
                  : displayList.length == 0
                      ? Text("Search yielded 0 results")
                      : ListView.separated(
                          separatorBuilder: (context, index) => Divider(
                            thickness: 0.0,
                            height: 0.0,
                            color: Colors.deepPurple[100],
                          ),
                          itemCount: displayList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                return DialogOnTap.info(
                                    context,
                                    displayList[index].name,
                                    stuORFac(index),
                                    stuORFacRoll(index));
                              },
                              title: Text(displayList[index].name),
                              leading: CircleAvatar(child: Icon(Icons.android)),
                              subtitle: IntrinsicHeight(
                                child: Row(
                                  children: <Widget>[
                                    Text(stuORFac(index)),
                                    VerticalDivider(
                                      color: Colors.deepPurple[300],
                                    ),
                                    Text(stuORFacRoll(index)),
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
              icon: Icon(Icons.settings), title: Text("Settings")),
          BottomNavigationBarItem(icon: Icon(Icons.call), title: Text("Call")),
        ],
      ),
    );
  }

  String stuORFac(int index) {
    String a = "STUDENT";
    String b = "FACULTY";
    if (displayList[index] is Student) {
      return a;
    } else {
      return b;
    }
  }

  String stuORFacRoll(int index) {
    if (displayList[index] is Student) {
      String a = displayList[index].rollno;
      return a;
    } else {
      String b = displayList[index].officenum.toString();
      return b;
    }
  }
}
