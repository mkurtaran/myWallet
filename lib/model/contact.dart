class Contact {
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
}
