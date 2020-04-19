import 'package:flutter/material.dart';

import 'model/contact.dart';

class AddContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Contact.contacts.add(Contact(name: "Ali", phoneNumber: "0565 656 5556"));

    return Scaffold(
      appBar: AppBar(
        title: Text("Ekleme"),
      ),
    );
  }
}
