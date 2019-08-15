import 'package:admin_app/DreamDetails.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';



class ListDreams extends StatefulWidget {

  ListDreams({Key key, this.title,}) : super(key:key);

  final String title;

  @override
  _ListDreamsState createState() => _ListDreamsState();
}

class _ListDreamsState extends State<ListDreams> {


  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      title: Text(widget.title),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.list),
          onPressed: () {},
        )
      ],
    );

    final bottomNav = Container(
      height: 55.0,
      child: BottomAppBar(
        color: Color.fromRGBO(58, 66, 86, 1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.home, color: Colors.white,),
                onPressed: () {}),
            IconButton(
                icon: Icon(Icons.account_circle, color: Colors.white,),
                onPressed: () {}),
            IconButton(
                icon: Icon(Icons.blur_on, color: Colors.white,),
                onPressed: () {})
          ],
        ),
      ),
    );

    ListTile cardListTile(String owner,String replyStatus,String dreamDetails,String dreamKey,String reply) =>
        ListTile(
          contentPadding: EdgeInsets.symmetric(
              horizontal: 20.0, vertical: 10.0),
          leading: Container(
            child: Icon(Icons.forum, color: Colors.blue,),
            padding: EdgeInsets.only(right: 12.0),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(width: 1.0, color: Colors.white24),
              ),
            ),
          ),
          title: Text(
            owner,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            children: <Widget>[
              Text(replyStatus, style: TextStyle(color: Colors.white),),
            ],
          ),
          trailing: Icon(
            Icons.keyboard_arrow_right, color: Colors.white, size: 30.0,),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DreamDetails(dreamDetails,dreamKey,reply)));
          },

        );

    Card listCard(String ownerName,String replyStatus,String dreamDetails,String dreamKey,String reply) =>
        Card(
          elevation: 8.0,
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(54, 75, 96, 0.9)),
            child: cardListTile(ownerName ,replyStatus,dreamDetails,dreamKey,reply),
          ),
        );


    FirebaseAnimatedList firebaseAnimatedList() => FirebaseAnimatedList(


      query:

        FirebaseDatabase.instance
          .reference()
          .child("dream").orderByChild('replystatus').equalTo('غير مفسر'),
      //scrollDirection: Axis.vertical,
      itemBuilder: (_,
          DataSnapshot snapshot,
          Animation<double> animation,
          int x){
                return listCard(snapshot.value['owner'],snapshot.value['replystatus'],snapshot.value['dreamDetails'],snapshot.key,snapshot.value['reply']);
      },
    );

    return Scaffold(

      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: topAppBar,
      body: firebaseAnimatedList(),
      bottomNavigationBar: bottomNav,
    );
  }

}

class Dream{

  String _firebasekey;
  int _age;
  String _dreamDetails;
  String _dreamTime;
  String _gender;
  String _maritalStatus;
  String _openedstatus;
  String _owner;
  String _ownerEmail;
  String _reply;
  String _replystatus;

  Dream(this._firebasekey, this._age, this._dreamDetails, this._dreamTime, this._gender,
      this._maritalStatus, this._openedstatus, this._owner, this._ownerEmail,
      this._reply, this._replystatus);


  Dream.fromSnapshot(DataSnapshot snapshot) :
        _firebasekey = snapshot.key,
        _age = snapshot.value["age"],
        _dreamDetails = snapshot.value["dreamDetails"],
        _dreamTime = snapshot.value["dreamTime"],
        _gender = snapshot.value["gender"],
        _maritalStatus = snapshot.value["maritalStatus"],
        _openedstatus = snapshot.value["openedstatus"],
        _owner = snapshot.value["owner"],
        _ownerEmail = snapshot.value["ownerEmail"],
        _reply = snapshot.value["reply"],
        _replystatus = snapshot.value["replystatus"];


  Dream.fromJson(this._firebasekey,Map data){

    _age = data["age"];
    _dreamDetails = data["dreamDetails"];
    _dreamTime = data["dreamTime"];
    _gender = data["gender"];
    _maritalStatus = data["maritalStatus"];
    _openedstatus = data["openedstatus"];
    _owner = data["owner"];
    _ownerEmail = data["ownerEmail"];
    _reply = data["reply"];
    _replystatus = data["replystatus"];
  }


  toJson(){
    return {
      "key" : firebasekey,
      "age" : dreamDetails,
      "dreamTime" : dreamTime,
      "gender": gender,
      "maritalStatus": maritalStatus,
      "openedstatus" : openedstatus,
      "owner" : owner,
      "ownerEmail" : ownerEmail,
      "reply" : reply,
      "replystatus" : replystatus
    };
  }


  String get firebasekey => _firebasekey;

  int get age => _age;

  String get dreamDetails => _dreamDetails;

  String get dreamTime => _dreamTime;

  String get gender => _gender;

  String get maritalStatus => _maritalStatus;

  String get openedstatus => _openedstatus;

  String get owner => _owner;

  String get ownerEmail => _ownerEmail;

  String get reply => _reply;

  String get replystatus => _replystatus;

}

