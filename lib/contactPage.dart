import 'package:flutter/material.dart';
import 'package:mywallet/addContactPage.dart';
import 'package:mywallet/database/db_helper.dart';
import 'package:mywallet/model/contact.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  List<Contact> contacts;
  DbHelper _dbHelper;

  @override
  void initState() {
    contacts = Contact.contacts;
    _dbHelper = DbHelper();
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
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddContactPage(
                          contact: Contact(),
                        )));
          },
          child: Icon(Icons.add),
        ),
        body: FutureBuilder(
            future: _dbHelper.getContact(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }

              if (snapshot.data.isEmpty) {
                return Text("Kayıt yok");
              }

              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    Contact item = snapshot.data[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddContactPage(
                                      contact: item,
                                    )));
                      },
                      child: Dismissible(
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          color: Colors.red,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        key: UniqueKey(),
                        onDismissed: (direction) async {
                          await _dbHelper.deleteContact(item.id);
                          setState(() {});

                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text("${item.name} silindi."),
                            action: SnackBarAction(
                              label: "Geri Al",
                              onPressed: () async {
                                await _dbHelper.insertContact(item);
                                setState(() {});
                              },
                            ),
                          ));
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(
                              item.avatar == null
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
                          trailing: IconButton(
                            icon: Icon(Icons.phone),
                            onPressed: () async =>
                                _callContact(item.phoneNumber),
                          ),
                        ),
                      ),
                    );
                  });
            }));
  }

  _callContact(String phoneNumber) async {
    String tel = "tel:$phoneNumber";

    if (await canLaunch(tel)) {
      await launch(tel);
    }
  }
}
