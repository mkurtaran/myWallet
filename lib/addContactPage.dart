import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'model/contact.dart';

class AddContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ekleme"),
      ),
      body: SingleChildScrollView(child: AddContactForm()),
    );
  }
}

class AddContactForm extends StatefulWidget {
  @override
  _AddContactFormState createState() => _AddContactFormState();
}

class _AddContactFormState extends State<AddContactForm> {
  final _formKey = GlobalKey<FormState>();
  File _file;

  @override
  Widget build(BuildContext context) {
    String name;
    String phoneNumber;

    return Column(
      children: <Widget>[
        Stack(children: [
          Image.asset(
            _file == null ? "assets/image/person.jpg" : _file.path,
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
                    validator: (val) {
                      if (val.isEmpty) {
                        return "İsim gereklidir";
                      }

                      return null;
                    },
                    onSaved: (val) {
                      name = val;
                    },
                    decoration: InputDecoration(hintText: "İsim Soyisim"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Telefon gereklidir";
                      }

                      return null;
                    },
                    onSaved: (val) {
                      phoneNumber = val;
                    },
                    decoration: InputDecoration(hintText: "Numara"),
                  ),
                ),
                RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text("Kaydet"),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      Contact.contacts.add(Contact(
                          name: name,
                          phoneNumber: phoneNumber,
                          avatar: _file == null ? "" : _file.path));

                      var snackBar = Scaffold.of(context).showSnackBar(SnackBar(
                        duration: Duration(milliseconds: 300),
                        content: Text("$name eklendi."),
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
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _file = image;
    });
  }
}
