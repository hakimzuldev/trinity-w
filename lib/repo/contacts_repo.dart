import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:trinity_w/model/contacts_model.dart';
import 'package:trinity_w/widget/logger.dart';

class ContactsRepo {
  Future<List<ContactsModel>> getContactsModel() async {
    logger('getContactsModel');

    try {
      logger('getContactsModel | trying to load');
      var jsonData = await rootBundle.loadString('assets/data.json');

      logger('getContactsModel | trying to decode');
      return ContactsModel.contactListFromJson(json.decode(jsonData));
    } catch (e) {
      logger('error getContactsModel');
      throw Exception();
    }
  }
}