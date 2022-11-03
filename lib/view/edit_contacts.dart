import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trinity_w/controller/contacts_controller.dart';
import 'package:trinity_w/helper/design.dart';
import 'package:trinity_w/model/contacts_model.dart';
import 'package:trinity_w/repo/contacts_repo.dart';
import 'package:trinity_w/widget/loading.dart';
import 'package:trinity_w/widget/modal.dart';

class EditContacts extends StatelessWidget {
  const EditContacts({Key? key, required this.contact}) : super(key: key);
  final ContactsModel contact;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContactsBloc>(
      create: (context) => ContactsBloc(ContactsRepo()),
      child: EditContactsView(contact: contact)
    );
  }
}
class EditContactsView extends StatefulWidget {
  const EditContactsView({Key? key, required this.contact}) : super(key: key);
  final ContactsModel contact;

  @override
  State<EditContactsView> createState() => _EditContactsViewState();
}

class _EditContactsViewState extends State<EditContactsView> {

  late ContactsBloc contactsBloc;
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();

  @override
  void initState() {
    contactsBloc = BlocProvider.of<ContactsBloc>(context);
    firstName.text = widget.contact.firstName ?? '';
    lastName.text = widget.contact.lastName ?? '';
    email.text = widget.contact.email ?? '';
    phone.text = widget.contact.phone ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(
              color: Colors.white
            ),
            title: const Text('Edit Contact', style: TextStyle(color: Colors.white)),
            elevation: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: GestureDetector(
                    onTap: () => checkSubmission(),
                    onLongPress: () {},
                    child: const Center(
                      child: Text(
                        'Save',
                        style: TextStyle(fontSize: 16, color: Colors.white)
                      )
                    )
                ),
              )
            ],
          ),
          body: BlocListener<ContactsBloc, ContactsState>(
            listener: (context, state) {
              if (state is SaveContactSuccess) {

              } else if (state is SaveContactError) {

              } else if (state is SaveContactLoading) {
                Loading.onScreen(context: context);
              }
            },
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: AppDesign.primaryColor
                          ),
                          child: Center(
                              child: Text(
                                '${widget.contact.firstName?[0]}${widget.contact.lastName?[0]}',
                                style: const TextStyle(fontSize: 40, color: Colors.white)
                              )
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      titleInfo('Main Information'),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            formField(title: 'First Name', controller: firstName, isRequired: true),
                            const SizedBox(height: 24),
                            formField(title: 'Last Name', controller: lastName, isRequired: true),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      titleInfo('Sub Information'),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            formField(title: 'Email', controller: email),
                            const SizedBox(height: 24),
                            formField(title: 'Phone', controller: phone, isNext: false),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
            ),
          )
      ),
    );
  }

  Widget formField({
    required String title, required TextEditingController? controller,
    bool isRequired = false, bool isNext = true,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
            flex: 1, child: Text(title)
        ),
        Expanded(
            flex: 2,
            child: SizedBox(
              // height: 40,
              child: TextField(
                controller: controller,
                style: const TextStyle(height: 1),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))
                    )
                ),
                textInputAction: isNext ? TextInputAction.next : TextInputAction.done,
              ),
            )
        ),
      ],
    );
  }

  Widget titleInfo(String title) {
    return Row(
      children: [
        Expanded(
          child: Container(
            color: Colors.grey[300],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(title, style: const TextStyle(fontSize: 16, color: Colors.black)),
            ),
          ),
        ),
      ],
    );
  }

  void checkSubmission() {
    if (firstName.text.isEmpty) {
      Modal.notificationModal(context: context, title: 'Uh-oh!', content: const Text('First name cannot be empty!'));
    } else if (lastName.text.isEmpty) {
      Modal.notificationModal(context: context, title: 'Uh-oh!', content: const Text('Last name cannot be empty!'));
    } else {
      ContactsModel contact = ContactsModel(
        widget.contact.id,
        firstName.text,
        lastName.text,
        email.text,
        phone.text
      );
      contactsBloc.add(SaveContact(contact: contact));
    }
  }
}

