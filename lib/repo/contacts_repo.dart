import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:trinity_w/model/contacts_model.dart';
import 'package:trinity_w/widget/logger.dart';

class ContactsRepo {
  Future<List<ContactsModel>> getContactsModel() async {
    logger('getContactsModel');

    try {
      logger('getContactsModel | trying to load');
      var jsonData = await rootBundle.loadString('assets/data.json');

      try {
        logger('getContactsModel | trying to getApplicationDocumentsDirectory');
        final path = await getApplicationDocumentsDirectory();

        logger('getContactsModel | trying to getFile');
        final file = File('$path/data.json');

        logger('getContactsModel | trying to writeAsString');
        file.writeAsString(jsonData);
      } catch (e) {
        throw Exception();
      }

      logger('getContactsModel | trying to decode');
      return ContactsModel.contactListFromJson(json.decode(jsonData));
    } catch (e) {
      logger('error getContactsModel');
      throw Exception();
    }
  }

  Future<bool> saveContact({required ContactsModel contact}) async {
    try {
      final path = await getApplicationDocumentsDirectory();
      final file = File('$path/data.json');

      var jsonData = await file.readAsString();

      List<ContactsModel> contacts = ContactsModel.contactListFromJson(json.decode(jsonData));

      contacts.removeWhere((element) => element.id == contact.id);
      contacts.add(contact);

      file.writeAsString(contacts.toString());

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<ContactsModel>> readContacts() async {
    final path = await getApplicationDocumentsDirectory();
    final file = File('$path/data.json');

    var jsonData = await file.readAsString();

    return ContactsModel.contactListFromJson(json.decode(jsonData));
  }
}