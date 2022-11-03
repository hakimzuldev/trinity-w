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
  }
}