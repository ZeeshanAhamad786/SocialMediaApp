import 'dart:math';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class dammyContacts extends StatefulWidget {
  const dammyContacts({Key? key}) : super(key: key);

  @override
  State<dammyContacts> createState() => _dammyContactsState();
}

class _dammyContactsState extends State<dammyContacts> {
  List<Contact>contacts = [];
  bool isLoading = true;

  @override
  void initState() {
    getContactPermission();
    super.initState();
  }

  void getContactPermission() async {
    if (await Permission.contacts.isGranted) {
      //contacts fetch
      fetcontacts();
    } else {
      await Permission.contacts.request();
    }
  }

  Future<void> fetcontacts() async {
    contacts = await ContactsService.getContacts();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar( backgroundColor: Colors.white,elevation: 0.5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.black,size: 20),

          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Contacts',style: TextStyle(color: Colors.black)),
      ),
      body: isLoading ? Center(child: CircularProgressIndicator(),) : ListView
          .builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return ListTile(
              leading: Container(
              height: 12.h,
              width: 8.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(boxShadow: [
              BoxShadow(blurRadius: 7,color: Colors.white.withOpacity(0.1),offset: Offset(-3,-3)),
          BoxShadow(blurRadius: 7,color: Colors.black.withOpacity(0.7),offset: Offset(3,3)),
          ],borderRadius: BorderRadius.circular(30),color: Colors.black),
          child: Text("A",style: TextStyle(fontSize: 23.sp,color: Colors.
          primaries[Random().nextInt(Colors.primaries.length)]),
          )
              ),
          title: Text(contacts[index].givenName!),
          subtitle: Text(contacts[index].phones![0].value!),
          onTap: () {
          // Handle the tap on a contact

          },
          );
        },
      ),
    );
  }
}


