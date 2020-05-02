import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
class ShowDonor2 extends StatefulWidget {
  
  ShowDonor2({ this.rollNo, this.title, this.author});
  final rollNo;
  final title;
  final author;
  @override
  _ShowDonor2State createState() => _ShowDonor2State();
}

class _ShowDonor2State extends State<ShowDonor2> {

  String donorEmail ="";
  String donorName = "";
  String userEmail = "";
  String userMob = "";
  String userName = "";
  String userRollNo = "";
   @override
  void initState() {
    super.initState();
      FirebaseAuth.instance.currentUser().then((user){
      setState((){
        userEmail = user.email;
      });
        Firestore.instance.collection('users').where('email' , isEqualTo : this.userEmail).getDocuments().then((QuerySnapshot docs){
          if(docs.documents.isNotEmpty){
            setState(() {
              userMob = docs.documents[0].data['mobNo'];
              userName = docs.documents[0].data['name'];
              userRollNo = docs.documents[0].documentID;
            });
          }
        }).whenComplete((){
            // print('username is : $userName  ans mob no : $userMob and mail :  $userEmail and rollNo : $userRollNo');
        });
      
    });
    // .whenComplete((){
    //     print('User is ' + userEmail);
    // });
    
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('users').document(widget.rollNo).snapshots(),
      
      builder: (context,snapshot){
        if(!snapshot.hasData) return Center(child : Text('Loading ...'));
        this.donorEmail = snapshot.data['email'];
        this.donorName  = snapshot.data['name'];
        
        return Container(
          width: MediaQuery.of(context).size.width,
          child: Card(
            child: 
              Column( 
                children: <Widget>[
                  SizedBox(height: 20),
                  Text(
                          'Donor Name : ${snapshot.data['name']}',
                          style: TextStyle(color: Colors.black),
                      ),
                    SizedBox(height: 10),
                    Text(
                          'Donor Contect No : ${snapshot.data['mobNo']}',
                          style: TextStyle(color: Colors.black),
                      ),
                    SizedBox(height: 10),
                    Text(
                          'Donor Email Id : ${snapshot.data['email']}',
                          style: TextStyle(color: Colors.black ),
                    ),
                    SizedBox(height: 10),
                    Container(
                    height: 45.0,
                    width: 150,
                    child: Material(
                      borderRadius: BorderRadius.circular(22.0),
                      shadowColor: Color.fromRGBO(58, 66, 86, 1.0),
                      color: Color.fromRGBO(58, 66, 86, 1.0),
                      elevation: 7.0,
                      child: GestureDetector(
                        onTap: sendEmail,
                        child: Center(
                          child: Text(
                            'Make Request',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                          ),
                        ),
                      ),
                    ),
                  ),
                    SizedBox(height: 20),
                ],
              ),
          ),
        );
      },
    );
  }

  

  Future<void> sendEmail() async{
    String username = '********'; //Your Email;
    String password = '********'; //Your Email's password;
    final timeStamp = new DateTime.now().millisecondsSinceEpoch.toString();
    final smtpServer = gmail(username, password); 
    // Creating the Gmail server
    String platformResponse;  
    // Create our email message.
    final message = Message()
      ..from = Address(username)
      ..recipients.add(this.donorEmail) //recipent email
      ..subject = 'Request For Book ${this.widget.title} By ${this.userName}' //subject of the email
      ..html = "<h3>Hello ${this.donorName}!</h3>\n<p>Your uploaded book named <strong>${this.widget.title} | ${this.widget.author}</strong> on Find Your Book App has a request By ${this.userName}.</p> <p>Contact Details are: <br>Roll No: ${this.userRollNo} <br>Name: ${this.userName} <br> Mobile No: ${this.userMob} <br> Email: ${this.userEmail}</p> \n<p> If you already delivered this book then click on this <a href='https://auth-ce30b.web.app/?date=$timeStamp&author=${this.widget.author}&title=${this.widget.title}&username=${this.widget.rollNo}' target='_blank' >link</a> to keep us updating.</p><p>Thanks!</p>";

    send(message, smtpServer).then((sendReport){
       platformResponse = 'Your request has been sent successfully.';
       print('Message sent: ' + sendReport.toString());
    }).catchError((e){
      platformResponse = 'Request not sent. Try again later';
      print('Message not sent. \n'+ e.toString()); 
    }).whenComplete(() => {
      _showToast(context , platformResponse)
    });
  }
  void _showToast(BuildContext context , String platformResponse) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(platformResponse , textAlign : TextAlign.center),
      ),
    );
  }
}
