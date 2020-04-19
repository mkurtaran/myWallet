import 'package:flutter/material.dart';
import 'package:mywallet/addContactPage.dart';
import 'package:mywallet/model/contact.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  List<Contact> contacts;

  @override
  void initState() {
    contacts = Contact.contacts;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Contact.contacts
        .sort((Contact a, Contact b) => a.name[0].compareTo(b.name[0]));

    return Scaffold(
      appBar: AppBar(
        title: Text("İlk uygulamam"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddContactPage()));
        },
        child: Icon(Icons.add),
      ),
      body: Container(
          child: ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (BuildContext context, int index) {
                Contact item = contacts[index];
                //return Text(item.name + " " + item.phoneNumber);
                return Container(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://images.pexels.com/users/avatars/251450/adrijana-453.jpeg?w=256&h=256&fit=crop&crop=faces&auto=compress"),
                        child: Text(
                          item.name[0],
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(item.name),
                            Text(item.phoneNumber)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Divider(
                          height: 2,
                        ),
                      ),
                    ],
                  ),
                );
              })),
    );
  }
}
