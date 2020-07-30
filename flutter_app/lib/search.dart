import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Student {

  String name, rollno, hostel;
  int room;
  Student({this.name, this.rollno, this.hostel, this.room});

}

class Faculty {

  String name, office, email, employeeid;
  int officenum;
  Faculty({this.name, this.office, this.officenum, this.email, this.employeeid});

}

class CustomRadioButton extends StatefulWidget {
  CustomRadioButton({
    this.radioButtonValue
  });

  final List buttonValues = ["EVERYONE", "STUDENT", "FACULTY"];
  final dynamic defaultSelected = "EVERYONE";
  final List<String> buttonLabels = ["EVERYONE", "STUDENT", "FACULTY"];
  final Function(dynamic) radioButtonValue;

  _CustomRadioButtonState createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  String _currentSelectedLabel;

  @override
  void initState() {
    super.initState();
    if (widget.defaultSelected != null) {
      if (widget.buttonValues.contains(widget.defaultSelected))
        _currentSelectedLabel = widget.defaultSelected;
      else
        throw Exception("Default Value not found in button value list");
    }
  }

  List<Widget> _buildButtonsRow() {
    List<Widget> buttons = [];
    for (int index = 0; index < widget.buttonLabels.length; index++) {
      var button = Card(
        margin: EdgeInsets.zero,
        color: _currentSelectedLabel == widget.buttonLabels[index]
            ? Colors.deepPurple[500]
            : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(3.5)),
          side: BorderSide(
            color: Colors.deepPurple[500],
          ),
        ),
        child: Container(
          height: 25.0,
          constraints: BoxConstraints(maxWidth: 250),
          child: MaterialButton(
            padding: EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 10.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(3.5)),
              side: BorderSide(
                color: Colors.deepPurple[500],
              ),
            ),
            onPressed: () {
              widget.radioButtonValue(widget.buttonValues[index]);
              setState(() {
                _currentSelectedLabel = widget.buttonLabels[index];
              });
            },
            child: Text(
              widget.buttonLabels[index],
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                color: _currentSelectedLabel == widget.buttonLabels[index]
                    ? Colors.white
                    : Colors.deepPurple[500],
                fontSize: 12.0,
              ),
            ),
          ),
        ),
      );
      buttons.add(button);
    }
    return buttons;
  }

  @override
  Widget build(BuildContext context) {
    return _buildRadioButtons();
  }

  _buildRadioButtons() {
    return Container(
      height: 31.0,
      child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _buildButtonsRow(),
          )
      ),
    );
  }
}

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  List<dynamic> people = [
    Student(name: "Ted Mosby", rollno: "EE12B290", hostel: "Cau", room: 204),
    Student(name: "Robin Scherbatsky", rollno: "CS13B243", hostel: "Gan", room: 128),
    Student(name: "Lily Aldrin", rollno: "ME12B295", hostel: "Sar", room: 317),
    Student(name: "Marshal Eriksen", rollno: "HS15B090", hostel: "Sha", room: 145),
    Faculty(name: "Barney Stinson", office: "HSB202", officenum: 235569, email: "EmW"),
    Faculty(name: "Rachel Green", office: "HSB202", officenum: 235569, email: "EmX"),
    Faculty(name: "Chandler Bing", office: "ESB202", officenum: 235569, email: "EmY"),
    Faculty(name: "Joey Tribbiani", office: "MSB202", officenum: 235569, email: "EmZ"),
  ];

  List filteredList = List();
  List displayList = List();
  bool searched = false;
  
  bool searchHandler(item, String string){
    bool value;
    if(string.length < 3){
      value = false;
    }else{
      if(item is Student){
        value = item.name.toLowerCase().contains(string.toLowerCase())
                || item.rollno.toLowerCase().contains(string.toLowerCase());
      }else{
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
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple[500], width: 0),
                    ),
                    prefixIcon: Icon(Icons.search),
                    hintText: "You'll find her, even roll number works",
                  ),
                  onChanged: (string){
                    setState(() {
                      string.length < 3? searched = false : searched = true;
                      filteredList = people.where((p) => searchHandler(p, string)).toList();
                      displayList = filteredList;
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 0),
              child: CustomRadioButton(
                radioButtonValue: (value){
                  if(value == "EVERYONE"){
                    setState(() {
                      displayList = filteredList;
                    });
                  }else if(value == "STUDENT") {
                    setState(() {
                      displayList = filteredList.where((p) => p is Student).toList();
                    });
                  }else {
                    setState(() {
                      displayList = filteredList.where((p) => p is Faculty).toList();
                    });
                  }
                },
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
              child: !searched? Text("No, you are not a stalker") :
              displayList.length == 0? Text("Search yielded 0 results") : 
              ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  thickness: 1.0,
                  height: 37.0,
                  color: Colors.grey[600],
                ),
                itemCount: displayList.length,
                itemBuilder: (context, index){
                  return ListTile(
                    onTap: () {},
                    title: Text(displayList[index].name),
                    leading: CircleAvatar(child: Icon(Icons.android)),
                    subtitle: IntrinsicHeight(
                      child: Row(
                        children: <Widget>[
                          displayList[index] is Student ? Text("STUDENT")
                              : displayList[index] is Faculty ? Text("FACULTY") : null,
                          VerticalDivider(
                            color: Colors.black,
                          ),
                          displayList[index] is Student ? Text(displayList[index].rollno)
                              : displayList[index] is Faculty ? Text((displayList[index].officenum).toString()) : null,
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
