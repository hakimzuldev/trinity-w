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
        final appDir = await getApplicationDocumentsDirectory();

        logger('getContactsModel | trying to getFile');
        final file = await File('${appDir.path}/data.json').create();

        logger('getContactsModel | trying to writeAsString');
        file.writeAsString(jsonData);
      } catch (e) {
        logger('getContactsModel | throw Exception 01 $e');
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
      final appDir = await getApplicationDocumentsDirectory();
      final file = File('${appDir.path}/data.json');

      var jsonData = await file.readAsString();

      List<ContactsModel> contacts = ContactsModel.contactListFromJson(json.decode(jsonData));

      contacts.removeWhere((element) => element.id == contact.id);
      contacts.add(contact);

      // String contactsParsed = contacts.map((e) => e.toJson()).toList().toString();
      await file.writeAsString(json.encode(contacts));
      // await file.writeAsString(contacts.map((e) => e.toJson()));

      return true;
    } catch (e) {
      logger('saveContactError: $e');
      return false;
    }
  }

  Future<List<ContactsModel>> readContacts() async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final file = File('${appDir.path}/data.json');

      var jsonData = await file.readAsString();
      logger('readContacts jsonData: ${jsonData}');

      return ContactsModel.contactListFromJson(json.decode(jsonData));
    } catch (e) {
      logger('readContactsError: ${e.toString()}');
      throw Exception();
    }
  }
}