class Contact {
  int id;
  String name;
  String phoneNumber;
  String avatar;

  static List<Contact> contacts = [
    Contact(name: "Ahmet", phoneNumber: "2323 2323 32323", avatar: ""),
    Contact(name: "Ahmet", phoneNumber: "2323 2323 32323", avatar: ""),
    Contact(name: "Ahmet", phoneNumber: "2323 2323 32323", avatar: ""),
    Contact(name: "Ahmet", phoneNumber: "2323 2323 32323", avatar: ""),
    Contact(name: "Ahmet", phoneNumber: "2323 2323 32323", avatar: ""),
    Contact(name: "Ahmet", phoneNumber: "2323 2323 32323", avatar: ""),
    Contact(name: "Mehmet", phoneNumber: "2323 2323 32323", avatar: "")
  ];

  Contact({this.name, this.phoneNumber, this.avatar});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["name"] = name;
    map["phone_number"] = phoneNumber;
    map["avatar"] = avatar;

    return map;
  }

  Contact.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    name = map["name"];
    phoneNumber = map["phone_number"];
    avatar = map["avatar"];
  }
}
