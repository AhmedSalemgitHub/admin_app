import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class DreamDetails extends StatefulWidget {
  final String _dreamDetails;
  final String _dreamKey;
  final String _reply;


  DreamDetails(this._dreamDetails, this._dreamKey, this._reply);

  @override
  _DreamDetailsState createState() => _DreamDetailsState();
}

class _DreamDetailsState extends State<DreamDetails> {
  TextEditingController textEditingController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    final DatabaseReference _databaseReference = FirebaseDatabase.instance
        .reference().child('dream').child(widget._dreamKey);

    String newReply ="";


    ListTile listTile(String title, String subTitle) {
      return ListTile(
        title: Text(
          title,
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
          style: TextStyle(fontSize: 20.0),
        ),
        subtitle: Text(
          subTitle,
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    Card listCard(String title, String subTitle) => Card(
          elevation: 8.0,
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(54, 75, 96, 0.9)),
            child: listTile(title, subTitle),
          ),
        );

    return
        //MaterialApp(
        //title: "Dream details",
        Scaffold(
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
            title: Text(widget._dreamKey),
          ),
          body: ListView(
            children: <Widget>[
              listCard("تفاصيل الحلم", widget._dreamDetails),
              listCard("رسائل التفسير القديمة", widget._reply),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("التفسير الجديد",textAlign: TextAlign.center,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: TextField(

                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    controller: textEditingController,
                    maxLines: 10,
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
              RaisedButton(
                child: Text('التفسير'),
                onPressed: () {
                  setState(() {
                    newReply = textEditingController.text;
                  });
                  if(widget._reply == "لم يتم التفسير")
                    {
                      _databaseReference.update({'reply':'$newReply'});
                    }else{
                    _databaseReference.update({'reply':'${widget._reply}\n $newReply'});
                  }

                  _databaseReference.update({'replystatus':'مفسر'});
                  Navigator.pop(context);
                },
              ),
        ],
      ),
    );
  }
}
