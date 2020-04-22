import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mywallet/database/db_helper.dart';
import 'model/contact.dart';

class AddContactPage extends StatelessWidget {
  final Contact contact;

  const AddContactPage({Key key, @required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contact.id == null ? "Yeni Kayıt Ekle" : contact.name),
      ),
      body: SingleChildScrollView(
          child: ContactForm(contact: contact, child: AddContactForm())),
    );
  }
}

class ContactForm extends InheritedWidget {
  final Contact contact;

  ContactForm({Key key, @required Widget child, @required this.contact})
      : super(key: key, child: child);

  static ContactForm of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ContactForm>();
  }

  @override
  bool updateShouldNotify(ContactForm oldWidget) {
    return contact.id != oldWidget.contact.id;
  }
}

class AddContactForm extends StatefulWidget {
  @override
  _AddContactFormState createState() => _AddContactFormState();
}

class _AddContactFormState extends State<AddContactForm> {
  final _formKey = GlobalKey<FormState>();
  File _file;
  DbHelper _dbHelper;

  @override
  void initState() {
    _dbHelper = DbHelper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Contact contact = ContactForm.of(context).contact;

    return Column(
      children: <Widget>[
        Stack(children: [
          Image.asset(
            contact.avatar == null ? "assets/image/person.jpg" : contact.avatar,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 200,
          ),
          Positioned(
            bottom: 8,
            right: 8,
            child: IconButton(
              onPressed: getFile,
              icon: Icon(Icons.camera_alt),
              color: Colors.blue,
            ),
          )
        ]),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    initialValue: contact.name,
                    validator: (val) {
                      if (val.isEmpty) {
                        return "İsim gereklidir";
                      }

                      return null;
                    },
                    onSaved: (val) {
                      contact.name = val;
                    },
                    decoration: InputDecoration(hintText: "İsim Soyisim"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    initialValue: contact.phoneNumber,
                    keyboardType: TextInputType.phone,
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Telefon gereklidir";
                      }

                      return null;
                    },
                    onSaved: (val) {
                      contact.phoneNumber = val;
                    },
                    decoration: InputDecoration(hintText: "Numara"),
                  ),
                ),
                RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text("Kaydet"),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();

                      if (contact.id == null) {
                        await _dbHelper.insertContact(contact);
                      } else {
                        await _dbHelper.updateContact(contact);
                      }

                      var snackBar = Scaffold.of(context).showSnackBar(SnackBar(
                        duration: Duration(milliseconds: 300),
                        content: Text("${contact.name} eklendi."),
                      ));

                      snackBar.closed.then((onValue) {
                        Navigator.pop(context);
                      });
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  void getFile() async {
    Contact contact = ContactForm.of(context).contact;
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      contact.avatar = image.path;
    });
  }
}
