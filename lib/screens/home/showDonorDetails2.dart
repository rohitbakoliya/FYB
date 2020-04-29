import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class ShowDonor2 extends StatelessWidget {
    final rollNo;
    ShowDonor2(this.rollNo);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('users').document(rollNo).snapshots(),
      builder: (context,snapshot){
        if(!snapshot.hasData) return Center(child : Text('Loading ...'));
        return Container(
          width: MediaQuery.of(context).size.width,
          child: Card(
            child: Column( 
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
                              onTap: (){},
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
}
