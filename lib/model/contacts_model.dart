import 'package:json_annotation/json_annotation.dart';
part 'contacts_model.g.dart';

@JsonSerializable()
class ContactsModel {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;

  ContactsModel(this.id, this.firstName, this.lastName, this.email, this.phone);

  static List<ContactsModel> contactListFromJson(str) => List<ContactsModel>.from(str.map((x) => ContactsModel.fromJson(x)));
  factory ContactsModel.fromJson(Map<String, dynamic> json) => _$ContactsModelFromJson(json);
  Map<String, dynamic> toJson() => _$ContactsModelToJson(this);
}