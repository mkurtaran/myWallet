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
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    setState(() {
                      contacts.removeAt(index);
                    });

                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("${item.name} silindi."),
                      action: SnackBarAction(
                        label: "Geri Al",
                        onPressed: () {
                          setState(() {
                            contacts.add(item);
                          });
                        },
                      ),
                    ));
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(
                        item.avatar.isEmpty
                            ? "assets/image/person.jpg"
                            : item.avatar,
                      ),
                      child: Text(
                        item.name[0],
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Text(item.name),
                    subtitle: Text(item.phoneNumber),
                  ),
                );
              })),
    );
  }
}
