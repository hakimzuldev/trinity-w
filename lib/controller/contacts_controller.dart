import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trinity_w/model/contacts_model.dart';
import 'package:trinity_w/repo/contacts_repo.dart';
import 'package:trinity_w/widget/logger.dart';

class ContactsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetContacts extends ContactsEvent {}

class SaveContact extends ContactsEvent {
  final ContactsModel contact;

  SaveContact({required this.contact});
}

class RefreshContacts extends ContactsEvent {}


class ContactsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ContactsStateIsInit extends ContactsState {}

class GetContactsSuccess extends ContactsState {
  final List<ContactsModel> contacts;

  GetContactsSuccess({required this.contacts});
}

class GetContactsError extends ContactsState {}
class GetContactsLoading extends ContactsState {}

class SaveContactSuccess extends ContactsState {}

class SaveContactError extends ContactsState {}
class SaveContactLoading extends ContactsState {}

class RefreshContactsSuccess extends ContactsState {
  final List<ContactsModel> contacts;

  RefreshContactsSuccess({required this.contacts});
}

class RefreshContactsError extends ContactsState {}
class RefreshContactsLoading extends ContactsState {}

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  // ContactsBloc(super.initialState);
  final ContactsRepo contactsRepo;

  ContactsBloc(this.contactsRepo) : super(ContactsStateIsInit()) {
    on<GetContacts>((event, emit) async {
      logger('GetContacts');

      emit(GetContactsLoading());

      try {
        final List<ContactsModel> contacts = await contactsRepo.getContactsModel();
        logger('GetContactsSuccess');
        logger(contacts);
        emit(GetContactsSuccess(contacts: contacts));
      } catch (e) {
        logger('GetContactsError');
        emit(GetContactsError());
      }
    });

    on<SaveContact>((event, emit) async {
      logger('SaveContact');
      emit(SaveContactLoading());

      try {
        final bool isSuccess = await contactsRepo.saveContact(contact: event.contact);
        logger('SaveContactSuccess');
        logger(isSuccess);
        emit(SaveContactSuccess());
      } catch (e) {
        logger('SaveContactsError');
        emit(SaveContactError());
      }
    });

    on<RefreshContacts>((event, emit) async {
      logger('RefreshContacts');
      emit(RefreshContactsLoading());

      try {
        final List<ContactsModel> contacts = await contactsRepo.readContacts();
        logger('RefreshContactsSuccess');
        logger(contacts);
        emit(RefreshContactsSuccess(contacts: contacts));
      } catch (e) {
        logger('RefreshContactsError');
        emit(RefreshContactsError());
      }
    });
  }
}